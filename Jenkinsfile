node() {
  def imageName = 'knowagelabs/knowage-r-docker-base'
  def imageVersion = "1.0"

  def builtImage = null

  def commonDockerLabels = " --label maintainer=https://www.knowage-suite.com/"
  def commonDockerBuildOpts = " "

  stage('Checkout') {
    checkout scm
  }

  stage('Build') {
    sh 'echo Building ${imageName}:${imageVersion}'
    builtImage = docker.build("${imageName}:${imageVersion}", "" + commonDockerLabels + commonDockerBuildOpts + " .")
  }

  stage('Push') {
    docker.withRegistry('', 'docker-hub') {
        builtImage.push("$imageVersion")
    }
  }

  stage('Clean up') {
    def hash = null
 
    hash = sh(script: "docker image inspect --format='{{.Id}}' ${imageName}:${imageVersion}", returnStdout: true)
        .trim()
        .split(":")[1]

    sh "docker rmi -f " + hash

  }
}