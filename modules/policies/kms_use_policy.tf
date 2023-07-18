data "aws_iam_policy_document" "kms_use" {
  statement {
    sid       = "Allow KMS Use"
    effect    = "Allow"
    actions   = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      "arn:aws:kms:eu-west-1:917046156167:key/ceaa4b5a-2168-4b59-b8e1-55a4ef587c01",
    ]
  }
}

resource "aws_iam_policy" "kms_use" {
  name        = "kmsuse"
  description = "Policy to allow use of KMS Key"
  policy      = data.aws_iam_policy_document.kms_use.json
}

resource "aws_iam_role_policy_attachment" "temp" {
  role       = aws_iam_role.temp_role_made_earlier.name
  policy_arn = aws_iam_policy.kms_use.arn
}
