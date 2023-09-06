for instance in bastion-container; do
  external_ip=$(aws ec2 describe-instances --filters \
    "Name=tag:Name,Values=${instance}" \
    "Name=instance-state-name,Values=running" \
    --output text --query 'Reservations[].Instances[].PublicIpAddress')

  scp -i ~/.ssh/id_rsa \
    mfa.sh \
    ubuntu@${external_ip}:~/
done