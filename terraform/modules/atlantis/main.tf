locals {
  atlantis_name = "atlantis-${var.environment}"
}

resource "helm_release" "atlantis" {
  name       = local.atlantis_name
  namespace  = var.namespace
  repository = "https://helm.runatlantis.io"
  chart      = "atlantis"

  values = [
    templatefile("${path.module}/helm_values.yaml", {
      github_user           = var.github_user
      github_token          = var.github_token
      github_webhook_secret = var.github_webhook_secret
    })
  ]

  depends_on = [kubernetes_namespace.atlantis]
}

resource "kubernetes_namespace" "atlantis" {
  metadata {
    name = var.namespace
    labels = {
      "app" = local.atlantis_name
    }
  }
}

data "kubernetes_service" "atlantis" {
  metadata {
    name      = local.atlantis_name
    namespace = var.namespace
  }

  depends_on = [helm_release.atlantis]
}
