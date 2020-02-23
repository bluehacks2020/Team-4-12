<%@ Application Language="C#" %>

<script runat="server">

    void Application_BeginRequest(object sender, EventArgs e)
    {
        /*
		var context = HttpContext.Current;
		var response = context.Response;
		
		// enable CORS
		response.AddHeader("Access-Control-Allow-Origin", "*");
		response.AddHeader("X-Frame-Options", "ALLOW-FROM *");
		
		if (context.Request.HttpMethod == "OPTIONS")
		{
			response.AddHeader("Access-Control-Allow-Methods", "GET, POST");
            response.AddHeader("Access-Control-Allow-Credentials", "true");
			response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept, Authorization");
			response.AddHeader("Access-Control-Max-Age", "1728000");
			response.End();
		}
        */

        HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "http://localhost:4400");
        if (HttpContext.Current.Request.HttpMethod == "OPTIONS")
        {
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "POST, GET");
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Credentials", "true");
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
            HttpContext.Current.Response.AddHeader("Access-Control-Max-Age", "1728000");
            HttpContext.Current.Response.End();
        }

    }

</script>