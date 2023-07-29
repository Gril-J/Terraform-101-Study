# Terraform 101 Study 4주차 정리 <!-- omit in toc -->

**Note:** 이 포스팅은 CloudNet@ 팀에서 진행하는 Terraform 101 Study의 4주차 내용을 정리한 글입니다.  

전체 소스 코드는 [GitHub](https://github.com/Gril-J/Terraform-101-Study)에서 확인 가능합니다.  

## State

테라폼은 Stateful 애플리케이션으로 프로비저닝 결과 State를 저장하고 추적에 활용합니다.  
State에는 작업자가 정의한 코드와 실제 반영된 프로비저닝 결과를 저장하고, 이 정보를 토대로 이후의 리소스 생성, 수정, 삭제에 대한 동작 판단 작업을 수행합니다.  
이러한 상태 파일은 배포할 때마다 변경되는 **프라이빗 API**로 오직 테라폼 내부에서 사용하기 위한 것으로 직접 편집하거나 읽는 코드를 작성하면 안됩니다.  

테라폼 State 관리 권장사항
  * State 파일은 버전 관리 시스템에 저장하지 않으며 공유 스토리지를 사용합니다.
  * 여러 팀원이 동시에 작업할 경우 충돌 가능성이 있어 상태 파일 잠금 기능을 사용합니다.
  * 환경에 대한 격리를 위해 여러 개의 State 파일을 사용합니다.

테라폼에서 상태 파일 격리하는 방법은 크게 2가지가 있습니다.
**Workspace** - 작업 공간을 통한 격리  
테라폼 구성 파일은 동일 하지만 작업자는 서로 다른 State를 갖는 실제 대상을 프로비저닝 할 수 있습니다.  
빠르고 쉽게 쓸 수 있다는 장점은 있지만 완벽한 격리를 보장하지는 않습니다.  
`terraform workspace` 명령어를 통해 작업 공간을 생성하고, `terraform workspace select` 명령어를 통해 작업 공간을 변경할 수 있습니다.  

**File layout** - 파일 구조를 통한 격리
테라폼 구성 파일을 분리된 폴더에서 관리 하여 서로 다른 백엔드를 만듭니다.  
보다 강력하게 분리해야 하는 운영 환경에 적합합니다.  

**최상위 폴더**

  - **stage** : 테스트 환경과 같은 사전 프로덕션 워크로드 workload 환경
  - **prod** : 사용자용 맵 같은 프로덕션 워크로드 환경
  - **mgmt** : 베스천 호스트 Bastion Host, 젠킨스 Jenkins 와 같은 데브옵스 도구 환경
  - **global** : S3, IAM과 같이 모든 환경에서 사용되는 리소스를 배치

**각 환경별 구성 요소**

  - **vpc** : 해당 환경을 위한 네트워크 토폴로지
  - **services** : 해당 환경에서 서비스되는 애플리케이션, 각 앱은 자체 폴더에 위치하여 다른 앱과 분리
  - **data-storage** : 해당 환경 별 데이터 저장소. 각 데이터 저장소 역시 자체 폴더에 위치하여 다른 데이터 저장소와 분리

## 모듈

모듈은 테라폼 구성의 집합 입니다. 테라폼으로 관리하는 대상의 규모가 커지고 복잡해져 생긴 문제를 보완하고 관리 작업을 수월하게 하기 위한 방안으로 활용합니.  
모듈를 사용하면 관리성, 캡슐화, 재사용성, 일관성, 표준화 등의 강점이 있습니다.  
모듈은 테라폼을 실행하고 프로비저닝하는 최상위 모듈인 **루트 모듈**과 로트 모듈 구성에서 호출하는 외부 구성 집합인 **자식 모듈**로 구분됩니다.  

**모듈 작성의 기본 원칙**

- 모듈 디렉터리 형식을 terraform-<프로바이더 이름>-<모듈 이름> 형식 사용 하기
- 테라폼 구성은 궁극적으로 모듈화가 가능한 구조로 작성 하기
- 각각의 모듈을 독립적으로 관리하기
- 공개된 테라폼 레지스트리의 모듈을 참고하기
- 디렉터리 구조를 생성할 때 모듈을 위한 별도 공간을 생성하는 방식으로 진행

**모듈화**

- 입력 변수를 구성하고 결과를 출력하기 위한 구조로 구성
- 작성된 모듈을 다른 루트 모듈에서 가져다 사용
- 루트 모듈과 자식 모듈 모두에 프로바이더 정의 가능

## 도전과제 1

### AWS DynamoDB/S3를 원격 저장소로 사용하기 <!-- omit in toc -->

## 도전과제 2

### 리소스를 모듈화 하고 해당 모듈을 사용해서 반복 리소스 만들기 <!-- omit in toc -->

정적 웹 호스팅을 위한 Public S3 생성 모듈을 작성

1. `modules` 디렉터리를 생성하고 `s3` 디렉터리를 생성 및 이동
2. `variables.tf` 파일을 생성하고 자식 모듈에서 사용할 변수들을 추가합니다.

    ```hcl
   variable "bucket_name" {
     description = "S3 Bucket Name"
   }
   
   variable "block_acl" {
     description = "S3 Bucket ACL"
     type = bool
   }
   
   variable "public_policy" {
     description = "S3 Bucket ACL"
     type = bool
   }
   
   variable "ignore_policy" {
     description = "S3 Bucket ACL"
     type = bool
   }
   
   variable "restrict_public" {
     description = "restrict_public"
     type = string
   }
    ```

3. `main.tf` 파일을 생성하고 아래내요을 추가합니다.

   ```tcl
   terraform {
     required_providers {
       aws = {
         source = "hashicorp/aws"
       }
     }
   }

   # S3 버킷을 생성
   resource "aws_s3_bucket" "gril_bucket" {
     bucket = var.bucket_name
   }
   # S3 버킷에 소유자 권한 설정
   resource "aws_s3_bucket_ownership_controls" "bucket_ownershop" {
     bucket = aws_s3_bucket.gril_bucket.id
   
     rule {
       object_ownership = "BucketOwnerPreferred"
     }
   }
   # S3 버컷의 정책을 설정
   resource "aws_s3_bucket_policy" "public_policy" {
     bucket = aws_s3_bucket.gril_bucket.id
     policy = data.aws_iam_policy_document.public_s3_policy.json
   }
   # 모든 사람이 해당 버킷의 컨텐츠를 볼 수 있는 정책을 설정
   data "aws_iam_policy_document" "public_s3_policy" {
     statement {
       sid      = "1"
       effect    = "Allow"
       actions = ["s3:GetObject"]
       resources = ["${aws_s3_bucket.gril_bucket.arn}/*"]
   
       principals {
         type        = "*"
         identifiers = ["*"]
       }
     }
   }
    # S3 버킷의 공개 접근을 설정
   resource "aws_s3_bucket_public_access_block" "gril_bucket_public" {
     bucket = aws_s3_bucket.gril_bucket.id
     block_public_acls   = var.block_acl
     block_public_policy = var.public_policy
     ignore_public_acls      = var.ignore_policy
     restrict_public_buckets = var.restrict_public
   }
   ```

4. `outputs.tf` 파일을 생성하고 아래 내용을 추가합니다.

   ```tcl
   output "bucket_id" {
     value = aws_s3_bucket.gril_bucket.id
   }
   output "bucket_arn" {
     value = aws_s3_bucket.gril_bucket.arn
   }
   ```

5. 루트 모듈로 돌아와 `variable.tf` 파일을 생성하고 모듈에서 사용할 변수을 추가합니다.  

   ```hcl
   variable "bucket_name"{
       description = "S3 Bucket Name"
       type = list(string)
       default = ["gril-terraform101-module-bucket1", "gril-terraform101-module-bucket2"]
   }
   ```

6. `main.tf` 파일을 생성하고 아래 내용을 추가합니다.

   ```tcl
   terraform {
     required_providers {
       aws = {
         source  = "hashicorp/aws"
         version = "~> 4.3"
       }
     }
   }
 
   provider "aws" {
     region = "ap-northeast-2"
   }
 
   module "s3_bucket_module" {
     for_each = toset(var.bucket_name)
     source = "./modules/s3_public" 
     bucket_name = each.value
     ignore_policy = false
     public_policy = false
     block_acl = false
     restrict_public = false
   }
   ```

7. `outputs.tf` 파일을 생성하고 아래 내용을 추가합니다.

   ```tcl
   output "bucket_id" {
     value = module.s3_bucket_module.*.bucket_id
   }
   output "bucket_arn" {
     value = module.s3_bucket_module.*.bucket_arn
   }
   ```

8. 배포하여 생성된 리소스를 확인 합니다.

   ```bash
   bucket_id = [
     "gril-terraform101-module-bucket1",
     "gril-terraform101-module-bucket2",
   ]
   
   terraform output              
   bucket_id = [
     "gril-terraform101-module-bucket1",
     "gril-terraform101-module-bucket2",
   ]
   
   terraform state list
   module.s3_bucket_module["gril-terraform101-module-bucket1"].data.aws_iam_policy_document.public_s3_policy
   module.s3_bucket_module["gril-terraform101-module-bucket1"].aws_s3_bucket.gril_bucket
   module.s3_bucket_module["gril-terraform101-module-bucket1"].aws_s3_bucket_ownership_controls.bucket_ownershop
   module.s3_bucket_module["gril-terraform101-module-bucket1"].aws_s3_bucket_policy.public_policy
   module.s3_bucket_module["gril-terraform101-module-bucket1"].aws_s3_bucket_public_access_block.gril_bucket_public
   module.s3_bucket_module["gril-terraform101-module-bucket2"].data.aws_iam_policy_document.public_s3_policy
   module.s3_bucket_module["gril-terraform101-module-bucket2"].aws_s3_bucket.gril_bucket
   module.s3_bucket_module["gril-terraform101-module-bucket2"].aws_s3_bucket_ownership_controls.bucket_ownershop
   module.s3_bucket_module["gril-terraform101-module-bucket2"].aws_s3_bucket_policy.public_policy
   module.s3_bucket_module["gril-terraform101-module-bucket2"].aws_s3_bucket_public_access_block.gril_bucket_public
   ```

   ![bucket1](./images/02-01.png)
   ![bucket2](./images/02-02.png)

## 도전과제 3

### 테라폼 레지스트리에 공개된 모듈을 사용하여 리소스 만들기 <!-- omit in toc -->

Terraform Rgistery에 공개된 [VPC 모듈](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws)을 사용하여 리소스를 만들어 보겠습니다.

1. `variables.tf` 파일을 생성하고 모듈에서 사용할 변수들을 추가합니다.

   ```hcl
   variable "azs" {
     type = list(string)
     default = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
   }
   
   variable "public_subnets" {
     type        = list(string)
     description = "List of public subnets"
     default     = ["100.10.1.0/24", "100.10.3.0/24", "100.10.5.0/24"]
   }
   
   
   variable "private_subnets" {
     type        = list(string)
     description = "List of public subnets"
     default     = ["100.10.2.0/24", "100.10.4.0/24", "100.10.6.0/24"]
   }
   
   
   variable "vpc_tag" {
     type = map(string)
     description = "value of ec2 tag"
     default     = {
       "Owner" = "Gril"
       "Purpose" = "SBX"
       "Environment" = "Dev"
     }
   }
   ```

2. `main.tf` 파일을 생성하고 아래 내용을 추가합니다.

  ```hcl
   module "vpc" {
     # 사용할 모듈을 지정
     source = "terraform-aws-modules/vpc/aws"
     # 모듈의 VPC 이름을 지정
     name = "gril-module-vpc"
     # 모듈의 CIDR 블록을 지정
     cidr = "100.10.0.0/16" 
     # 변수 내용을 참고하여 모듈에 전달할 인자를 지정
     azs                 = var.azs
     private_subnets     = var.public_subnets
     public_subnets      = var.private_subnets
   
     create_database_subnet_group = false
   
     # DNS HOST, DHCP 활성화
     enable_dns_hostnames = true
     enable_dns_support   = true
     enable_dhcp_options  = true
   
     # 단일 NAT GATEWAY 활성화
     enable_nat_gateway = true
     single_nat_gateway = true
     enable_vpn_gateway = false
     # 변수 내용을 참고하여 모듈에 전달할 인자를 지정
     tags = var.vpc_tag
   
   }
  ```

1. 배포하여 생성된 리소를 확인합니다.

  ```bash
   Apply complete! Resources: 25 added, 0 changed, 0 destroyed.

   $ terraform state list
   data.aws_security_group.default
   module.vpc.aws_default_network_acl.this[0]
   module.vpc.aws_default_route_table.default[0]
   module.vpc.aws_default_security_group.this[0]
   module.vpc.aws_eip.nat[0]
   module.vpc.aws_internet_gateway.this[0]
   module.vpc.aws_nat_gateway.this[0]
   module.vpc.aws_route.private_nat_gateway[0]
   module.vpc.aws_route.public_internet_gateway[0]
   module.vpc.aws_route_table.private[0]
   module.vpc.aws_route_table.public[0]
   module.vpc.aws_route_table_association.private[0]
   module.vpc.aws_route_table_association.private[1]
   module.vpc.aws_route_table_association.private[2]
   module.vpc.aws_route_table_association.public[0]
   module.vpc.aws_route_table_association.public[1]
   module.vpc.aws_route_table_association.public[2]
   module.vpc.aws_subnet.private[0]
   module.vpc.aws_subnet.private[1]
   module.vpc.aws_subnet.private[2]
   module.vpc.aws_subnet.public[0]
   module.vpc.aws_subnet.public[1]
   module.vpc.aws_subnet.public[2]
   module.vpc.aws_vpc.this[0]
   module.vpc.aws_vpc_dhcp_options.this[0]
   module.vpc.aws_vpc_dhcp_options_association.this[0]
  ```

   ![vpc](./images/03-01.png)
   ![subnet](./images/03-02.png)
   ![natgateway](./images/03-03.png)

## 도전과제 4

### 깃허브를 모듈 소스로 설정하여 리소스 배포하기 <!-- omit in toc -->
