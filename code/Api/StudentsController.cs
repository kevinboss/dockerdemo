using System.Collections.Generic;  
using System.Linq;  
using Microsoft.AspNetCore.Mvc;

namespace dockerdemo.API  
{
    [Route("api/[controller]")]
    public class StudentsController : Controller
    {
        private readonly StudentContext _context; 

        public StudentsController(StudentContext context)
        {
            _context = context;
        }

        // GET: api/students  
        public IEnumerable<Student> Get()  
        {  
            return _context.Students.ToList();  
        }  

        // GET api/students/1  
        [HttpGet("{id}")]  
        public Student Get(int id)  
        {  
            return _context.Students.FirstOrDefault(x => x.Id == id);  
        }  

        // POST api/students  
        [HttpPost]  
        public IActionResult Post([FromBody]Student value)  
        {  
            _context.Students.Add(value);  
            _context.SaveChanges();  
            return StatusCode(201, value);  
        }  

    }
}