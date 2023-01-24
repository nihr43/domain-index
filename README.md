This is a quick static site to serve some links.

Im using terraform and cert-manager in kubernetes for effortless deployment, TLS, SNI, etc:

```
resource "kubernetes_deployment" "domain-index" {
  metadata {
    name = "domain-index"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "domain-index"
      }
    }
    template {
      metadata {
        labels = {
          app = "domain-index"
        }
      }
      spec {
        container {
          image = "images.local:5000/domain-index"
          name  = "domain-index"
        }
      }
    }
  }
}

resource "kubernetes_service" "domain-index" {
  wait_for_load_balancer = "false"
  metadata {
    name = "domain-index"
  }
  spec {
    selector = {
      app = "domain-index"
    }
    port {
      port        = "8000"
      target_port = "8000"
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "domain-index" {
  metadata {
    name = "domain-index"
    annotations = {
      "kubernetes.io/ingress.class" = "public"
      "cert-manager.io/issuer" = "letsencrypt-prod"
    }
  }
  spec {
    rule {
      host = "nih.earth"
      http {
        path {
          backend {
            service {
              name = "domain-index"
              port {
                number = 8000
              }
            }
          }
        path = "/"
        path_type = "Prefix"
        }
      }
    }
    tls {
      hosts = ["nih.earth"]
      secret_name = "domain-index-tls"
    }
  }
}
```
