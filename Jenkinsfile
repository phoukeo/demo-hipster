properties([[$class: 'JiraProjectProperty'], gitLabConnection(''),
  parameters([
    choice(choices: ['apply', 'delete'], description: '', name: 'mode'),
    credentials(name: 'cluster1', credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'user1-anthos-ansiblized-kubeconfig', description: '', required: true),
    credentials(name: 'cluster2', credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'chicken-crossed-the-road-kubeconfig', description: '', required: true)
    ])])

podTemplate(
  cloud: 'kubernetes',
  containers: [
    containerTemplate(name: 'anthos', image: 'thilavanh/centos-kubectl', ttyEnabled: true,)]
)
{
  node(POD_LABEL) {
      stage('Get an Anthos project') {
          container('anthos') {
              stage('Install Hybrid Hipster Demo Application')
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
