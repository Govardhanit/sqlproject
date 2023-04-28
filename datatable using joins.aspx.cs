using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Web.Script.Serialization;

namespace sqlproject1
{
    public partial class datatabtable_using_joins : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class Employee
        {
            public string Name { get; set; }
            public string Department { get; set; }
            public int Year_of_experience { get; set; }
            public decimal Current_salary { get; set; }
        }
        [WebMethod]
        public static List<Employee> Getdatabase()
        {
            List<Employee> Details = new List<Employee>();
            string constr = ConfigurationManager.ConnectionStrings["connect"].ConnectionString;
            using (MySqlConnection con = new MySqlConnection(constr))
            {
                using (MySqlCommand cmd = new MySqlCommand("SELECT emp.Name, cd.Department, ed.Year_of_experience, ed.Current_salary FROM employee emp JOIN employeeDetails ed ON emp.empID = ed.empID JOIN companydetails cd ON cd.DepID = ed.DepID;", con))
                {
                    con.Open();
                    using (MySqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            Details.Add(new Employee
                            {
                                Name = sdr["Name"].ToString(),
                                Department = sdr["Department"].ToString(),
                                Year_of_experience = Convert.ToInt32(sdr["Year_of_experience"]),
                                Current_salary = Convert.ToDecimal(sdr["Current_salary"])
                            });
                        }
                    }
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            return (Details);
        }
    }

  
}
