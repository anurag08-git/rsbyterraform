provider "kubernetes" {
  
  config_context_cluster   = "minikube"
}

resource "kubernetes_deployment" "mysql" {
  metadata {
    name = "mysql"
    
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        env = "dev"
        dc = "IN"
        app = "webserver"
 
      }

      match_expressions { 
          
        key = "dc"
        operator = "In"
        values = ["IN","US"] 
          
         }


      match_expressions { 
          
        key = "env"
        operator = "In"
        values = ["dev" , "prod"]
          
         }


      match_expressions { 
          
        key = "app"
        operator = "In"
        values = ["webserver"]
          
         }

    }

     template {
       metadata {
        name = "mysqlpod"
        labels = {
          env = "dev"
          dc = "IN"
          app = "webserver"
        }
      }

       spec {
        container {
         image = "mysql:5.6"
         name  = "mysql"

        env {
          name  = "MYSQL_ROOT_PASSWORD"
          value = "redhat"
          }
        env {
          name  = "MYSQL_DATABASE"
          value = "mylwdb"
          }
        env {
          name  = "MYSQL_USER"
          value = "anurag"
        }

        env {
          name  = "MYSQL_PASSWORD"
          value = "anuragpassword"
            }
         
         }
    }

  }
 }
}