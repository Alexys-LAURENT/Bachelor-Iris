using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

builder.Services.AddMvc().AddRazorPagesOptions(options =>
{
    options.Conventions.ConfigureFilter(new IgnoreAntiforgeryTokenAttribute());
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
