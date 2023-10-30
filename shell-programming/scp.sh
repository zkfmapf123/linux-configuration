EXTERNAL_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=linux-container" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)

echo $EXTERNAL_IP

scp -i ~/.ssh/id_rsa *.sh ec2-user@$EXTERNAL_IP:~/