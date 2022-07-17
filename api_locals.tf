locals {
  api_gw = {
    name = "my-api-gw"
    resources = {
      users = {
        parent = ""
        path   = "users"
      }

      categories = {
        parent = ""
        path  = "categories"
      }

      category = {
        parent = "categories"
        path   = "{id}"
      }

      timesheets = {
        parent = ""
        path   = "timesheets"
      }

      timesheet = {
        parent = "timesheets"
        path   = "{id}"
      }

      reports = {
        parent = ""
        path   = "reports"
      }
    }
    endpoints = {
      get_users = {
        method      = "GET"
        full_path   = "users"
        path        = "users"
        lambda_name = "get_users"
      }

      put_user = {
        method      = "PUT"
        full_path   = "users"
        path        = "users"
        lambda_name = "put_user"
      }

      create_user = {
        method      = "POST"
        full_path   = "users"
        path        = "users"
        lambda_name = "create_user"
      }

      get_report = {
        method      = "GET"
        full_path   = "reports"
        path        = "reports"
        lambda_name = "get_report"
      }

      get_timesheet = {
        method      = "GET"
        full_path   = "timesheets/{id}"
        path        = "{id}"
        lambda_name = "get_timesheet"
      }

      get_timesheet_by_userid = {
        method      = "GET"
        full_path   = "timesheets"
        lambda_name = "get_timesheet_by_userid"
      }

      put_timesheet = {
        method      = "PUT"
        full_path   = "timesheets/{id}"
        path        = "{id}"
        lambda_name = "put_timesheet"
      }

      post_timesheet = {
        method      = "POST"
        full_path   = "timesheets"
        path        = "timesheets"
        lambda_name = "post_timesheet"
      }

      delete_timesheet = {
        method      = "DELETE"
        full_path   = "timesheets/{id}"
        path        = "{id}"
        lambda_name = "delete_timesheet"
      }

      get_category = {
        method      = "GET"
        full_path   = "categories/{id}"
        path        = "{id}"
        lambda_name = "get_category"
      }

      put_category = {
        method      = "PUT"
        full_path   = "categories/{id}"
        path        = "{id}"
        lambda_name = "put_category"
      }

      post_category = {
        method      = "POST"
        full_path   = "categories"
        path        = "categories"
        lambda_name = "post_category"
      }

      delete_category = {
        method      = "DELETE"
        full_path   = "categories/{id}"
        path        = "{id}"
        lambda_name = "delete_category"
      }

      get_categories = {
        method      = "GET"
        full_path   = "categories"
        path        = "categories"
        lambda_name = "get_categories"
      }
    }
  }

  lambda_functions = {
    functions = {
      get_users = {
        name    = "get-users"
        zip     = "./resources/lambdas/get_users.zip"
        handler = "get_users.handler"
        runtime = "nodejs16.x"
      }
      put_user = {
        name    = "put-user"
        zip     = "./resources/lambdas/put_user.zip"
        handler = "put_user.handler"
        runtime = "nodejs16.x"
      }
      post_user = {
        name    = "post-user"
        zip     = "./resources/lambdas/post_user.zip"
        handler = "post_user.handler"
        runtime = "nodejs16.x"
      }
      get_report = {
        name    = "get-report"
        zip     = "./resources/lambdas/get_report.zip"
        handler = "get_report.handler"
        runtime = "nodejs16.x"
      }
      get_timesheet = {
        name    = "get-timesheet"
        zip     = "./resources/lambdas/get_timesheet.zip"
        handler = "get_timesheet.handler"
        runtime = "nodejs16.x"
      }

      get_timesheet_by_userid = {
        name    = "get-timesheet-by-userid"
        zip     = "./resources/lambdas/get_timesheet_by_userid.zip"
        handler = "get_timesheet_by_userid.handler"
        runtime = "nodejs16.x"
      }
      put_timesheet = {
        name    = "put-timesheet"
        zip     = "./resources/lambdas/put_timesheet.zip"
        handler = "put_timesheet.handler"
        runtime = "nodejs16.x"
      }
      post_timesheet = {
        name    = "post-timesheet"
        zip     = "./resources/lambdas/post_timesheet.zip"
        handler = "post_timesheet.handler"
        runtime = "nodejs16.x"
      }
      delete_timesheet = {
        name    = "delete-timesheet"
        zip     = "./resources/lambdas/delete_timesheet.zip"
        handler = "delete_timesheet.handler"
        runtime = "nodejs16.x"
      }
      get_category = {
        name    = "get-category"
        zip     = "./resources/lambdas/get_category.zip"
        handler = "get_category.handler"
        runtime = "nodejs16.x"
      }
      put_category = {
        name    = "put-category"
        zip     = "./resources/lambdas/put_category.zip"
        handler = "put_category.handler"
        runtime = "nodejs16.x"
      }
      post_category = {
        name    = "post-category"
        zip     = "./resources/lambdas/post_category.zip"
        handler = "post_category.handler"
        runtime = "nodejs16.x"
      }
      delete_category = {
        name    = "delete-category"
        zip     = "./resources/lambdas/delete_category.zip"
        handler = "delete_category.handler"
        runtime = "nodejs16.x"
      }
      get_categories = {
        name    = "get-categories"
        zip     = "./resources/lambdas/get_categories.zip"
        handler = "get_categories.handler"
        runtime = "nodejs16.x"
      }
    }
  }
}
