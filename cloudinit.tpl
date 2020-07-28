#cloud-config
write_files:
  - path: /usr/local/bin/resource_checker.sh
    encoding: b64
    permissions: 0755
    content: ${resource_checker}
  - path: /usr/local/bin/count_words.py
    encoding: b64
    permissions: 0755
    content: ${count_words}

runcmd:
  - sudo yum update -y
  - sudo yum install -y docker python3.8
  - sudo service docker start
  - sudo docker run -d --name nginx -p 8080:80 nginx:latest
  - python /usr/local/bin/count_words.py &
  - bash /usr/local/bin/resource_checker.sh &
