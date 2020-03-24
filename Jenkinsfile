podTemplate(
  cloud: 'kubernetes',
  containers: [
      containerTemplate(name: 'anthos', image: 'thilavanh/centos-kubectl', ttyEnabled: true)
    ]) {

      node(POD_LABEL) {
          stage('Get an Anthos project') {
              container('anthos') {
                  stage('Install Hybrid Hipster Demo Application') {
                    // git (url: 'https://github.com/phoukeo/demo-hipster.git', credentialsId: 'phoukeo-github')
                    // withCredentials([
                    //   file(credentialsId: "${params.cluster1}", variable: 'KUBECONFIG1'),
                    //   file(credentialsId: "${params.cluster2}", variable: 'KUBECONFIG2')])
                    //   {
                    parameters {
                      choice(name: 'mode', choices: ['apply', 'delete'], description: 'apply, delete' )
                      choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
                      credentials(name: 'cluster1', defaultValue: "user1-anthos-ansiblized-kubeconfig (user1 kubeconfig anthos)", description: 'Your User Cluster1', credentialType: "Secret file", required: true)
                      credentials(name: 'cluster2', defaultValue: "chicken-crossed-the-road-kubeconfig (chicken-crossed-the-road kubeconfig creds)", description: 'Your User Cluster2', credentialType: "Secret file", required: true)
                    }
                      {
                        sh """
                        echo $cluster1
                        echo ${params.mode}
                        echo ${params.cluster1}
                        kubectl --kubeconfig $cluster2 ${params.mode} -f ./hybrid/onprem -n hipster
                        kubectl --kubeconfig $cluster1 ${params.mode} -f ./hybrid/cloud -n hipster
                        """
                      }
                  }
              }
          }
      }
  }
