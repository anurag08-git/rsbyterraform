provider "kubernetes" {
  
  config_context_cluster   = "minikube"
}

resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "mywp"
    
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
        name = "mywp"
        labels = {
          env = "dev"
          dc = "IN"
          app = "webserver"
        }
      }

       spec {
        container {
         image = "wordpress:4.8-apache"
         name  = "wp"

       
    }

  }
 }
 }
}