locals {
  api_gw = {
    name = "my-api-gw"
    resources = {
      users = {
        parent = ""
        path   = "users"
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
      create_user = {
        name    = "create-user"
        zip     = "./resources/lambdas/create_user.zip"
        handler = "create_user.handler"
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
    }
  }
}
