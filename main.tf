data "external" "thumbprint" {
  program = ["${path.module}/get_thumbprint.sh", var.region]
}

resource "aws_iam_openid_connect_provider" "openid_connect_provider" {
  lifecycle {
    ignore_changes = [data.external.thumbprint.result.thumbprint]
  }
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.thumbprint.result.thumbprint]
  url             = var.cluster_oidc_issuer_url
}