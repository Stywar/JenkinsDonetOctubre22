pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
               git branch: 'master', url: 'https://github.com/Stywar/JenkinsDonetOctubre22'
            }
        }
        
      stage ('Build Net6.0') {
           steps {
            bat(script: 'dir' , returnStdout:true);
            bat(script: 'dotnet restore' , returnStdout:true);
            bat(script: 'dotnet build' , returnStdout:true);
            bat(script: 'dotnet test' , returnStdout:true);
           }
       }
     stage ("Docker Build") {
           
           steps{
             // docker login  
             bat(script: 'docker build -t antony0618/servicenet60 .' , returnStdout:true);
             bat(script: 'docker push antony0618/servicenet60' , returnStdout:true);  
           }
       }   
       
       
        stage ("Deploy AKS") {
           steps {
            bat(script: 'az login --service-principal --username 60445a5a-4c7d-404e-96a0-0d5c83c4978f --password TzxNjUtzdLtnERRfCl78.0BRMJrl8rG_bQ --tenant 74343d69-5375-4c7a-8cc9-08986488c964', returnStdout: true);
            bat(script: 'az account set --subscription "Developer"', returnStdout: true);
            bat(script: 'az aks get-credentials --resource-group Devops --name k8sOcrubre22 & kubectl config get-contexts --kubeconfig=%KUBE_PATH_CONFIG%', returnStdout: true);
            bat(script: 'kubectl config use-context k8sOcrubre22 --kubeconfig=%KUBE_PATH_CONFIG%', returnStdout: true);
            bat(script: 'kubectl apply -f k8s.yml --kubeconfig=%KUBE_PATH_CONFIG%', returnStdout: true);
            bat(script: 'kubectl rollout restart deployment app-deployment --kubeconfig=%KUBE_PATH_CONFIG%', returnStdout: true);
           }
       }
    }
}
