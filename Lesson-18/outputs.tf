output "created_iam_users_all" {
    value = aws_iam_user.users
}

output "created_iam_users_id" {
    value = aws_iam_user.users[*].id
}

output "created_iam_users_custom" {
    value = [
        for user in aws_iam_user.users:
        "Username: ${user.name} has ARN ${user.arn}"

    ]
}

output "created_iam_users_map" {
    value = {
        for user in aws_iam_user.users:
        user.unique_id => user.id
    }
}

output "server_all" {
    value = {
    for server in aws_instance.servers :
    server.id => server.public_ip
    }
  
}