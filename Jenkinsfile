podTemplate(
  cloud: 'kubernetes',
  containers: [
      containerTemplate(name: 'anthos', image: 'thilavanh/centos-kubectl', ttyEnabled: true)
    ]) {

      node(POD_LABEL) {
          stage('Get an Anthos project') {
              container('anthos') {
                parameters {
                  choice(choices: ['apply', 'delete'], description: 'apply, delete', name: 'mode')
                  credentials(defaultValue: "user1-anthos-ansiblized-kubeconfig (user1 kubeconfig anthos)", description: 'Your User Cluster1', credentialType: "Secret file", name: 'cluster1', required: true, variable: 'KUBECONFIG1')
                  credentials(defaultValue: "chicken-crossed-the-road-kubeconfig (chicken-crossed-the-road kubeconfig creds)", description: 'Your User Cluster2', credentialType: "Secret file", name: 'cluster2', required: true, variable: 'KUBECONFIG1')
                }
                  stage('Install Hybrid Hipster Demo Application') {
                    // git (url: 'https://github.com/phoukeo/demo-hipster.git', credentialsId: 'phoukeo-github')
                    // withCredentials([
                    //   file(credentialsId: "${params.cluster1}", variable: 'KUBECONFIG1'),
                    //   file(credentialsId: "${params.cluster2}", variable: 'KUBECONFIG2')])
                    //   {
                        sh """
                        kubectl --kubeconfig ${params.cluster2} ${params.mode} -f ./hybrid/onprem -n hipster
                        kubectl --kubeconfig ${params.cluster1} ${params.mode} -f ./hybrid/cloud -n hipster
                        """
                      // }
                  }
              }
          }
      }
  }
