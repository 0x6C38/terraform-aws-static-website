resource "aws_s3_bucket" "website_bucket_redirect" {
  bucket = "${local.domain_name}-redirect"

  tags = {
    Name = "${local.domain_name} Redirect"
    # Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "redirect_bucket_website_config" {
  bucket = aws_s3_bucket.website_bucket_redirect.id
  redirect_all_requests_to {
    host_name = local.domain_name
  }
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = local.domain_name

  tags = {
    Name = "${local.domain_name} Website"
    # Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.public_read_policy_document.json
}

data "aws_iam_policy_document" "public_read_policy_document" {
  statement {
    sid = "PublicReadForGetBucketObjects"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.website_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "bucket_website_config" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}