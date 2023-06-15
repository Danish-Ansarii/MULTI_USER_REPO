node {
   stage('get git code'){
      git branch:'main',url:'https://github.com/Danish-Ansarii/MULTI_USER_REPO.git'
   }
   stage('send docker file to ansible'){
      sshagent(['dani']) {
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59'
      sh 'scp /var/lib/jenkins/workspace/pipeline/* ubuntu@172.31.46.59:/home/ubuntu'

      }  
   }
   stage('Build Docker file'){
      sshagent(['dani']) {
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59  cd /home/ubuntu'
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59  docker image build -t $JOB_NAME:v1.$BUILD_ID .'
      }  
   }
   stage('tag docker file'){
      sshagent(['dani']) {
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59  cd /home/ubuntu'
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59 docker image tag $JOB_NAME:v1.$BUILD_ID danish84464/$JOB_NAME:v1.$BUILD_ID'
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59  docker image tag $JOB_NAME:v1.$BUILD_ID danish84464/latest'
      }
   }
   stage('push Docker image to Docker hub'){
      sshagent(['dani']) {
         withCredentials([string(credentialsId: 'docker_pass', variable: 'docker_pass')]) {
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59 docker login -u danish84464 -p ${docker_pass}'
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59 docker image push danish84464/$JOB_NAME:v1.$BUILD_ID'
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59 docker image push danish84464/latest'
         }
      }
   }

   stage('Send Deployment.yaml to k8s Cluster'){
      sshagent(['k8s']) {
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.65.255.25'
      sh 'scp /var/lib/jenkins/workspace/pipeline/* ubuntu@54.65.255.25:/home/ubuntu/'
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.65.255.25 whoami'
      }      
   }      
     


    stage('Run playbook in ansible'){
      sshagent(['dani']) {
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59'
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59 ansible -i hosts -m ping node'
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.46.59 ansible-playbook -i hosts playbook.yaml'
      }  
   }
   stage('check all'){
      sshagent(['dani']) {
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.65.255.25'
      sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.65.255.25 kubectl get all'


   }
}
}