import boto3
import json
import datetime
from botocore.exceptions import ClientError
from dateutil.tz import tzutc

# Initialize clients
iam_client = boto3.client('iam')
ssm_client = boto3.client('ssm')
sns_client = boto3.client('sns')

# SNS topic ARN - Replace with your actual SNS topic ARN
SNS_TOPIC_ARN = 'arn:aws:sns:us-east-2:362255407745:Fetch_deleteNotification'

def get_parameter(name):
    try:
        response = ssm_client.get_parameter(Name=name)
        return int(response['Parameter']['Value'])
    except ClientError as e:
        print(f"Error getting parameter {name}: {e}")
        return None

def get_unused_roles(threshold_days):
    paginator = iam_client.get_paginator('list_roles')
    roles = []
    threshold_date = datetime.datetime.now(tz=tzutc()) - datetime.timedelta(days=threshold_days)
    
    for page in paginator.paginate():
        for role in page['Roles']:
            role_name = role['RoleName']
            last_used_response = iam_client.get_role(RoleName=role_name)
            last_used_date = last_used_response['Role']['RoleLastUsed'].get('LastUsedDate', None)
            if last_used_date is None:
                last_used_date = last_used_response['Role']['CreateDate']
            
            if last_used_date < threshold_date:
                roles.append(role)
    
    return roles

def get_role_owner_email(role_name):
    try:
        response = iam_client.list_role_tags(RoleName=role_name)
        tags = response.get('Tags', [])
        for tag in tags:
            if tag['Key'] == 'email':
                return tag['Value']
    except ClientError as e:
        print(f"Error getting tags for role {role_name}: {e}")
    return None

def send_notification(role_name, email, delete_date, notification_type):
    if notification_type == 'pre-deletion':
        message = f"The IAM role '{role_name}' has not been used for the specified period and is scheduled for deletion on {delete_date}. Please take action if you want to retain this role."
        subject = 'IAM Role Deletion Notice'
    elif notification_type == 'post-deletion':
        message = f"The IAM role '{role_name}' has been successfully deleted as it was not used within the specified period."
        subject = 'IAM Role Deleted'
    
    try:
        sns_client.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=message,
            Subject=subject,
            MessageStructure='string'
        )
    except ClientError as e:
        print(f"Error sending {notification_type} notification: {e}")

def delete_role(role_name):
    try:
        iam_client.delete_role(RoleName=role_name)
        print(f"Deleted role: {role_name}")
        return True
    except ClientError as e:
        print(f"Error deleting role: {role_name}, {e}")
        return False

def lambda_handler(event, context):
    unused_period_days = get_parameter('/iam-role-cleanup/unused-period-days') or 11
    notification_period_days = get_parameter('/iam-role-cleanup/notification-period-days') or 1

    unused_roles = get_unused_roles(unused_period_days)
    delete_date = (datetime.datetime.now(tz=tzutc()) + datetime.timedelta(days=notification_period_days)).strftime('%Y-%m-%d')

    for role in unused_roles:
        role_name = role['RoleName']
        owner_email = get_role_owner_email(role_name)
        if owner_email:
            send_notification(role_name, owner_email, delete_date, 'pre-deletion')
            
            # Schedule role for deletion
            # Here we simulate waiting for the notification period to pass, for the sake of example we'll delete immediately.
            deletion_successful = delete_role(role_name)
            if deletion_successful:
                send_notification(role_name, owner_email, delete_date, 'post-deletion')

    return {
        'statusCode': 200,
        'body': json.dumps('Notifications sent and roles processed.')
    }