pipeline {
    agent any

    environment {
        // Force Terraform to run non-interactively
        TF_IN_AUTOMATION = 'true'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Sushilrpattebahadur/Terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                // This block securely injects the JSON key file as a variable
                withCredentials([file(credentialsId: 'gcp-sa-key', variable: 'GCP_KEY_FILE')]) {
                    script {
                        // Tell Terraform where to find the key
                        sh 'export GOOGLE_APPLICATION_CREDENTIALS=$GCP_KEY_FILE && terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([file(credentialsId: 'gcp-sa-key', variable: 'GCP_KEY_FILE')]) {
                    script {
                        sh 'export GOOGLE_APPLICATION_CREDENTIALS=$GCP_KEY_FILE && terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                input message: 'Review the plan. Apply changes?', ok: 'Yes, Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([file(credentialsId: 'gcp-sa-key', variable: 'GCP_KEY_FILE')]) {
                    script {
                        sh 'export GOOGLE_APPLICATION_CREDENTIALS=$GCP_KEY_FILE && terraform apply -input=false tfplan'
                    }
                }
            }
        }
    }
}
