using System.Net;
using Microsoft.AspNetCore.Mvc;

namespace Controllers
{
    [Route("api")]
    [ApiController]
    public class CourseController : ControllerBase
    {
        private readonly HttpClient _httpClient;
        private readonly IConfiguration _settings;

        public CourseController(HttpClient httpClient, IConfiguration settings)
        {
            _httpClient = httpClient;
            _settings = settings;
        }

        [HttpGet("courses")]
        public async Task<string> GetAllCourses([FromQuery] long? limit)
        {
            var response = await _httpClient.GetAsync($"{_settings["ApiSettings:BaseUrl"]}/api/course?limit={(limit != null ? limit : 10)}");
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }

        [HttpGet("courses/{id}")]
        public async Task<string> GetCourseRecommendation([FromRoute] long id)
        {
            var response = await _httpClient.GetAsync($"{_settings["ApiSettings:BaseUrl"]}/api/course/{id}");
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }

        [HttpGet("search")]
        public async Task<string> GetSearchRecommendation([FromQuery] string query, [FromQuery] long? limit)
        {
            var response = await _httpClient.GetAsync($"{_settings["ApiSettings:BaseUrl"]}/api/search?limit={(limit != null ? limit : 5)}&query={query}");
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }
    }
}
