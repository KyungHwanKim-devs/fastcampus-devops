# 프로바이더를 AWS로 설정
provider "aws" {
  region = "ap-northeast-2"
}

/*
 * No count / for_each 반복문 없이 각각 부여
 */
resource "aws_iam_user" "user_1" {
  name = "user-1"
}

resource "aws_iam_user" "user_2" {
  name = "user-2"
}

resource "aws_iam_user" "user_3" {
  name = "user-3"
}

output "user_arns" {
  value = [
    aws_iam_user.user_1.arn,
    aws_iam_user.user_2.arn,
    aws_iam_user.user_3.arn,
  ]
}


/*
 * count 를 이용한 반복문
 */

resource "aws_iam_user" "count" {
  count = 10

  name = "count-user-${count.index}"
}

# variables 파일은 이용한 데이터 참조 이용
resource "aws_iam_user" "ex" {
  count = length(var.user_names)

  name = element(var.user_names, count.index)
}

output "count_user_arns" {
  value = [aws_iam_user.ex.*.arn, aws_iam_user.count.*.arn]
}

/*
 * for_each 반복문
 */

resource "aws_iam_user" "for_each_set" {
  for_each = toset([
    "for-each-set-user-1",
    "for-each-set-user-2",
    "for-each-set-user-3",
  ])

  # for_each 쓰면 블록 안에서 each.key, each.value 사용 가능
  name = each.key
}

output "for_each_set_user_arns" {
  value = values(aws_iam_user.for_each_set).*.arn
}

resource "aws_iam_user" "for_each_map" {
  for_each = {
    alice = {
      level   = "low"
      manager = "posquit0"
    }
    bob = {
      level   = "mid"
      manager = "posquit0"
    }
    john = {
      level   = "high"
      manager = "steve"
    }
  }

  name = each.key

  tags = each.value
}

output "for_each_map_user_arns" {
  value = values(aws_iam_user.for_each_map).*.arn
}
