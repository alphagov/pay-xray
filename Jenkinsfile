#!/usr/bin/env groovy

pipeline {
  agent any

  options {
    ansiColor('xterm')
    timestamps()
  }

  libraries {
    lib("pay-jenkins-library@master")
  }

  stages {
    stage('Docker Build') {
      steps {
        script {
          buildAppWithMetrics{
            app = "xray"
          }
        }
      }
      post {
        failure {
          postMetric("xray.docker-build.failure", 1)
        }
      }
    }

    stage('Docker Tag') {
      steps {
        script {
          dockerTagWithMetrics {
            app = "xray"
          }
        }
      }
      post {
        failure {
          postMetric("xray.docker-tag.failure", 1)
        }
      }
    }
    stage('Tag Build') {
      when {
        branch 'master'
      }
      steps {
        tagDeployment("xray")
      }
    }
  }
  post {
    failure {
      postMetric(appendBranchSuffix("xray") + ".failure", 1)
    }
    success {
      postSuccessfulMetrics(appendBranchSuffix("xray"))
    }
  }
}
