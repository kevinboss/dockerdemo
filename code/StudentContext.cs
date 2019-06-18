using System;  
using Microsoft.EntityFrameworkCore;

namespace dockerdemo  
{
    public class StudentContext: DbContext
    {
        public StudentContext
        (DbContextOptions<StudentContext> options)  
            : base(options)  
        { }

        public DbSet<Student> Students { get; set; }
    }
}