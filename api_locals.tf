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
        path   = "categories"
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
      post_user = {
        method      = "POST"
        full_path   = "users"
        path        = "users"
        lambda_name = "post_user"
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
      # get_timesheets_by_userid = {
      #   method      = "GET"
      #   full_path   = "timesheets?user_id={user_id}"
      #   path        = "{user_id}"
      #   lambda_name = "get_timesheets_by_userid"
      # }
      # get_timesheets_by_categoryid = {
      #   method      = "GET"
      #   full_path   = "timesheets?category_id={category_id}"
      #   path        = "{category_id}"
      #   lambda_name = "get_timesheets_by_categoryid"
      # }

      get_timesheets = {
        method      = "GET"
        full_path   = "timesheets"
        path        = "timesheets"
        lambda_name = "get_timesheets"
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
        zip     = "./resources/lambdas/get_users/get_users.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      put_user = {
        name    = "put-user"
        zip     = "./resources/lambdas/put_user/put_user.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      post_user = {
        name    = "post-user"
        zip     = "./resources/lambdas/post_user/post_user.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      get_report = {
        name    = "get-report"
        zip     = "./resources/lambdas/get_report/get_report.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      get_timesheet = {
        name    = "get-timesheet"
        zip     = "./resources/lambdas/get_timesheet/get_timesheet.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      get_timesheets = {
        name    = "get-timesheets"
        zip     = "./resources/lambdas/get_timesheets/get_timesheets.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      # get_timesheets_by_categoryid = {
      #   name    = "get-timesheets-by-categoryid"
      #   zip     = "./resources/lambdas/get_timesheets_by_categoryid/get_timesheets_by_categoryid.zip"
      #   handler = "get_timesheets_by_categoryid.handler"
      #   runtime = "nodejs16.x"
      # }

      # get_timesheets_by_userid = {
      #   name    = "get-timesheets-by-userid"
      #   zip     = "./resources/lambdas/get_timesheets_by_userid/get_timesheets_by_userid.zip"
      #   handler = "get_timesheets_by_userid.handler"
      #   runtime = "nodejs16.x"
      # }
      put_timesheet = {
        name    = "put-timesheet"
        zip     = "./resources/lambdas/put_timesheet/put_timesheet.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      post_timesheet = {
        name    = "post-timesheet"
        zip     = "./resources/lambdas/post_timesheet/post_timesheet.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      delete_timesheet = {
        name    = "delete-timesheet"
        zip     = "./resources/lambdas/delete_timesheet/delete_timesheet.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      get_category = {
        name    = "get-category"
        zip     = "./resources/lambdas/get_category/get_category.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      put_category = {
        name    = "put-category"
        zip     = "./resources/lambdas/put_category/put_category.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      post_category = {
        name    = "post-category"
        zip     = "./resources/lambdas/post_category/post_category.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      delete_category = {
        name    = "delete-category"
        zip     = "./resources/lambdas/delete_category/delete_category.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
      get_categories = {
        name    = "get-categories"
        zip     = "./resources/lambdas/get_categories/get_categories.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }

      create_tables = {
        name    = "create-tables"
        zip     = "./resources/lambdas/create_tables/create_tables.zip"
        handler = "index.handler"
        runtime = "nodejs16.x"
      }
    }
  }
}
