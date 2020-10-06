pipeline {
  agent any
  parameters {
    password (name: 'AWS_ACCESS_KEY_ID')
    password (name: 'AWS_SECRET_ACCESS_KEY')
  }
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
  }
  stages {
  
     stage('checkout') {
          steps {
                git url: 'https://github.com/MSidda/iot11.git',branch:'master'
          }
        }
   
   stage('Terraform Init') {
      steps {
        bat "${env.TERRAFORM_HOME}\terraform init -input=false"
      }
    }
  }
}
