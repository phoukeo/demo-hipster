podTemplate(
  cloud: 'kubernetes',
  containers: [
      containerTemplate(name: 'anthos', image: 'thilavanh/centos-kubectl', ttyEnabled: true)
    ]) {
      parameters {
        choice(choices: ['apply', 'delete'], description: 'apply, delete', name: 'mode')
        credentials(defaultValue: "user1-anthos-ansiblized-kubeconfig", description: 'Your User Cluster1', credentialType: "Secret file", name: 'cluster1', required: true)
        credentials(defaultValue: "chicken-crossed-the-road-kubeconfig", description: 'Your User Cluster2', credentialType: "Secret file", name: 'cluster2', required: true)
      }

      node(POD_LABEL) {
          stage('Get an Anthos project') {
              container('anthos') {
                  stage('Install Hybrid Hipster Demo Application') {
                    git (url: 'https://github.com/phoukeo/demo-hipster.git', credentialsId: 'phoukeo-github')
                    withCredentials([
                      file(credentialsId: '${params.cluster1}', variable: 'KUBECONFIG1'),
                      file(credentialsId: '${params.cluster2}', variable: 'KUBECONFIG2')])
                     {
                        sh """
                        kubectl --kubeconfig $KUBECONFIG2 ${params.mode} -f ./hybrid/onprem -n hipster
                        kubectl --kubeconfig $KUBECONFIG1 ${params.mode} -f ./hybrid/cloud -n hipster
                        """
                      }
                  }
              }
          }
      }
  }
