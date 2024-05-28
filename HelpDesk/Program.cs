var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

// Configure Antiforgery options
builder.Services.AddAntiforgery(options =>
{
    options.Cookie.SameSite = SameSiteMode.None; // Set the SameSite policy to None
    options.Cookie.SecurePolicy = CookieSecurePolicy.Always; // Ensure the cookie is sent only over HTTPS
    options.Cookie.HttpOnly = true; // Ensure the cookie is accessible only through HTTP requests
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

// Add the middleware to set security headers
app.Use(async (context, next) =>
{
    // Set Content-Security-Policy to allow framing from any domain
    context.Response.Headers.Add("Content-Security-Policy", "frame-ancestors *");
    await next();
});

app.MapRazorPages();

app.Run();
