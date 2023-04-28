using MySql.Data.MySqlClient;
using MySqlX.XDevAPI.Relational;
using Newtonsoft.Json;
using Org.BouncyCastle.Crypto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Numerics;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;


namespace sqlproject
{
    public class data
    {
        public string person_id { get; set; }
        public string name { get; set; }
        public string last_name { get; set; }
        public string phone { get; set; }
        public string gender { get; set; }
        public string language { get; set; }
        public string drop { get; set; }
        public string places { get; set; }
        public string edit { get; set; }
        public string delete { get; set; }
    }

    public class getData
    {
        public string name { get; set; }
        public string last_name { get; set; }
        public string phone { get; set; }
        public string gender { get; set; }
        public string language { get; set; }
        public string drop { get; set; }
        public string places { get; set; }
    }
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string getData(string id)
        {
            var list = new List<getData>();
            string connetionString = "server=localhost;user=root;database=trial;password=Govi@njssql2002";
            MySqlConnection cnn = new MySqlConnection(connetionString);
            var query = "SELECT * FROM person WHERE personID = '" + id + "'";
            var ds = new DataSet();
            var da = new MySqlDataAdapter(query, cnn);
            da.Fill(ds, "results");

            foreach (DataRow row in ds.Tables["results"].Rows)
            {
                var name = row["Name"].ToString();
                var last_name = row["lastName"].ToString();
                var phone = row["Phone"].ToString();
                var gender = row["Gender"].ToString();
                var language = row["Language"].ToString();
                var native = row["Native"].ToString();
                var places = row["Places"].ToString();

                list.Add(new getData
                {
                    name = name,
                    last_name = last_name,
                    phone = phone,
                    gender = gender,
                    language = language,
                    drop = native,
                    places = places
                });
            }

            return JsonConvert.SerializeObject(list);
        }

        [WebMethod]
        public static string GetTable()
        {
            string connetionString = "server=localhost;user=root;database=trial;password=Govi@njssql2002";
            MySqlConnection cnn = new MySqlConnection(connetionString);
            var list = new List<data>();
            try
            {
                cnn.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT * FROM person where is_deleted = 0", cnn);
                var query = "SELECT * FROM person where is_deleted = 0";

                var ds = new DataSet();
                var da = new MySqlDataAdapter(query, cnn);
                da.Fill(ds, "results");

                foreach (DataRow row in ds.Tables["results"].Rows)
                {
                    var person_id = row["personID"].ToString();
                    var name = row["Name"].ToString();
                    var last_name = row["lastName"].ToString();
                    var phone = row["Phone"].ToString();
                    var gender = row["Gender"].ToString();
                    var language = row["Language"].ToString();
                    var native = row["Native"].ToString();
                    var places = row["Places"].ToString();
                    var edit = "<button class=\"edit-button\" type=\"button\" onclick=\"edit('" + person_id + "')\"><i class=\"fas fa-edit\"></i></button>";
                    var delete = "<button class=\"delete-button\" type=\"button\" onclick=\"delet('" + person_id + "')\"><i class=\"fas fa-trash-alt\"></i></button>";
                  

                    list.Add(new data
                    {
                        person_id = person_id,
                        name = name,
                        last_name = last_name,
                        phone = phone,
                        gender = gender,
                        language = language,
                        drop = native,
                        places = places,
                        edit = edit,
                        delete = delete
                      
                    });

                }


                //MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                //DataTable table = new DataTable();
                //adapter.Fill(table);

                // Serialize the DataTable to JSON and return it
                return JsonConvert.SerializeObject(list);
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
            finally
            {
                cnn.Close(); // Always close the connection in a finally block
            }
        }

        [WebMethod]
        public static bool SubmitData(string Name, string LastName, string Phone, string Gender, string Language, string Native, string Places)
        {
            string connetionString = "server=localhost;user=root;database=trial;password=Govi@njssql2002";
            MySqlConnection cnn = new MySqlConnection(connetionString);
            string sql = "INSERT INTO person (Name, lastName, Phone, Gender, Language, Native, Places) VALUES ('" + MySqlHelper.EscapeString(Name) + "','" + LastName.Replace("'", "''") + "', '" + Phone + "', '" + Gender + "', '" + Language + "', '" + Native + "', '" + MySqlHelper.EscapeString(Places) + "')";
            try
            {
                cnn.Open();
                MySqlCommand cmd = new MySqlCommand(sql, cnn);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public class dd
        {
            public int Id { get; set; }
            public string DisplayText { get; set; }
        }

        [WebMethod]
        public static List<dd> GetDropdownData()
        {
            List<dd> dropdownList = new List<dd>();

            string connectionString = "server=localhost;user=root;database=trial;password=Govi@njssql2002";
            MySqlConnection connection = new MySqlConnection(connectionString);

            try
            {
                connection.Open();
                MySqlCommand command = new MySqlCommand("SELECT * FROM dropdown", connection);
                MySqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    dd dropdown = new dd
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        DisplayText = reader["display_text"].ToString()
                    };
                    dropdownList.Add(dropdown);
                }

                //reader.Close();
            }
            catch (Exception)
            {
                // Handle exception
            }
            finally
            {
                connection.Close();
            }
            return dropdownList;
        }
        [WebMethod]
        public static string GetPlaces(string district)
        {
            List<string> places = new List<string>();
            var Select = "";
            string connectionString = "server=localhost;user=root;database=trial;password=Govi@njssql2002;";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string query = "SELECT place FROM placess WHERE district = '" + district + "'";

                var ds = new DataSet();
                var da = new MySqlDataAdapter(query, connection);
                da.Fill(ds, "results");

                foreach (DataRow row in ds.Tables["results"].Rows)
                {
                    var pla = row["place"].ToString();
                    places.Add(pla);
                }

                Select = new JavaScriptSerializer().Serialize(places).ToString();

            }
            return Select;
        }
        [WebMethod]
        public static void DeletePerson(string id)

        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["connecting"].ConnectionString;
            MySqlConnection connection = new MySqlConnection(connectionString);
            var query = "UPDATE person SET is_deleted = 1 WHERE personID ='" + id + "'";

            try
            {
                connection.Open();
                MySqlCommand cmd = new MySqlCommand(query, connection);

                // Set the personID parameter value
                //    cmd.Parameters.AddWithValue("'" + personID + "'", personID);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while deleting person: " + ex.Message);
                // Log the error or handle it as needed
                // For example, you can throw a custom exception or return an error response to the client
            }
        }
        [WebMethod]
        public static void Deletedatas(List<string> ids)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["connecting"].ConnectionString;
            MySqlConnection connection = new MySqlConnection(connectionString);
            var query = "UPDATE person SET is_deleted = 1 WHERE personID IN (" + string.Join(",", ids) + ")";

            try
            {
                connection.Open();
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred while deleting rows: " + ex.Message);
                // Log the error or handle it as needed
                // For example, you can throw a custom exception or return an error response to the client
            }
        }
     

        [WebMethod]
        public static string UpdatePerson(string Name, string LastName, string Phone, string Gender, string Language, int personID, string Native, string Places)
        {
            string connectionString = "server=localhost;user=root;database=trial;password=Govi@njssql2002";
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                connection.Open();
                using (MySqlCommand command = new MySqlCommand("UPDATE person SET Name = @Name, lastName = @LastName, Phone = @Phone, Gender = @Gender, Language = @Language, Native = @Native, Places = @Places WHERE personID = @personID", connection))
                {
                    command.Parameters.AddWithValue("@Name", Name);
                    command.Parameters.AddWithValue("@LastName", LastName);
                    command.Parameters.AddWithValue("@Phone", Phone);
                    command.Parameters.AddWithValue("@Gender", Gender);
                    command.Parameters.AddWithValue("@Language", Language);
                    command.Parameters.AddWithValue("@Native", Native);
                    command.Parameters.AddWithValue("@Places", Places);
                    command.Parameters.AddWithValue("@personID", personID);
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        return "Person information updated successfully";
                    }
                    else
                    {
                        return "Failed to update person information";
                    }
                }
            }
        }
    }
}