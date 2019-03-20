Public Module RouteConfig
    Sub RegisterRoutes(ByVal routes As RouteCollection)
        routes.MapPageRoute("Default", "Default.aspx", "~/Default.aspx")
        routes.MapPageRoute("Contact", "ContactUs.aspx", "~/ContactUs.aspx")
        routes.MapPageRoute("About", "About.aspx", "~/About.aspx")
        routes.MapPageRoute("DynamicPage", "{PageName}", "~/DynamicPage.aspx")
    End Sub
End Module
