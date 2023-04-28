<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="sqlproject.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link href="https://gyrocode.github.io/jquery-datatables-checkboxes/1.2.12/css/dataTables.checkboxes.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
    <!--Buttons-->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <!--search panes-->
    <link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" />
    <!--fontsweaome-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet" />
    <!--Select2-->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <title></title>
    <style>
        .fas.fa-edit {
            color: green;
        }

        .fas.fa-trash-alt {
            color: red;
        }

        .fa fa-check {
            color: blueviolet;
        }

        .fas fa-sync-alt {
            color: crimson;
        }
    </style>
</head>
<body>
    <input type="hidden" id="auto_id" />
    <div class="container">
        <form id="form2" runat="server">
            <div class="form-group">
                <label for="Name">Name:</label>
                <input type="text" class="form-control" id="Name" />
            </div>
            <div class="form-group">
                <label for="LastName">Last Name:</label>
                <input type="text" class="form-control" id="LastName" />
            </div>
            <div class="form-group">
                <label for="Phone">Phone.no:</label>
                <input type="tel" class="form-control" id="Phone" name="Phone.no" />
            </div>
            <div class="form-group">
                <label>Gender:</label>
                <div class="form-check">
                    <input type="radio" class="form-check-input" id="male" name="gender" value="male" />
                    <label class="form-check-label" for="male">Male</label>
                </div>
                <div class="form-check">
                    <input type="radio" class="form-check-input" id="female" name="gender" value="female" />
                    <label class="form-check-label" for="female">Female</label>
                </div>
            </div>
            <div class="form-group">
                <label>Languages known:</label>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="language[]" value="English" id="english" />
                    <label class="form-check-label" for="english">English</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="language[]" value="French" id="french" />
                    <label class="form-check-label" for="french">French</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" name="language[]" value="Spanish" id="spanish" />
                    <label class="form-check-label" for="spanish">Spanish</label>
                </div>
            </div>
            <div class="form-group">
                <label for="Native">Native:</label>
                <select class="form-control" id="Native" name="Native"></select>
            </div>
            <div>
                <label for="Places">Places:</label>
                <select name="Places" class="js-example-basic-multiple" id="Places" placeholder="select you places to go " multiple="multiple" style="width: 100%;">
                </select>
            </div>
            <br />
            <br />
            <button type="button" class="btn btn-primary" id="submitButton" onclick="submitData()">
                <i class="fa fa-check"></i>Submit
           
            </button>
            <button type="button" class="btn btn-secondary" id="update-btn" style="display: none;"><i class="fas fa-sync-alt"></i>Update </button>
        </form>
        <div class="container mt-5">
            <table id="example" class="table table-striped" style="width: 105%">
                <thead>
                    <tr>
                        <th>PersonID</th>
                        <th></th>
                        <th></th>
                        <th>Name</th>
                        <th>Last Name</th>
                        <th>Phone</th>
                        <th>Gender</th>
                        <th>Languages</th>
                        <th>Native</th>
                        <th>Places</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- table data will be generated dynamically here -->
                </tbody>
            </table>
            <button type="button" class="btn btn-danger" id="delete-btn" disabled="disabled">
  <i class="fas fa-trash"></i> Delete Datas
</button>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <!--DataTables-->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="//gyrocode.github.io/jquery-datatables-checkboxes/1.2.12/js/dataTables.checkboxes.min.js"></script>
    <!--Buttons-->
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <!--search panes-->
    <script src="https://cdn.datatables.net/searchpanes/2.1.2/js/dataTables.searchPanes.min.js"></script>
    <script src="https://cdn.datatables.net/select/1.6.2/js/dataTables.select.min.js"></script>
    <!--Select2-->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"></script>
    <script>

        $('.js-example-basic-multiple').select2({
            placeholder: 'Select places to go '
        });
        function submitData() {
            debugger
            var Name = document.getElementById("Name").value;
            var LastName = document.getElementById("LastName").value;
            var Phone = document.getElementById("Phone").value;
            var gender = $('input[name=gender]:checked').val();
            var language = $('input[name="language[]"]:checked').map(function () {
                return this.value;
            }).get().join(", ");
            var Native = $("#Native").val();
            var Places = $('#Places').select2('data').map(val => val.text).join(',');

            $.ajax({
                type: "POST",
                url: "WebForm1.aspx/SubmitData",
                data: JSON.stringify({ Name: Name, LastName: LastName, Phone: Phone, Gender: gender, Language: language, Native: Native, Places: Places }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    debugger
                    if (response.d) {
                        loadDataTable(); // reload the DataTable after submitting data
                        // Clear the input fields
                        $('#Name').val('');
                        $('#LastName').val('');
                        $('#Phone').val('');
                        $('input[name=gender]').prop('checked', false);
                        $('input[name="language[]"]').prop('checked', false);
                        $('#Native').val('');
                        $('#Places').val(null).trigger('change');

                    } else {
                        alert("Error: Data could not be inserted.");
                    }
                },
                error: function (response) {
                    alert("Error: " + response.responseText);
                }
            });
        }
        var tableInitialized = false; // keep track of whether the DataTable has been initialized
        function format(d) {
            // `d` is the original data object for the row
            return (
                '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
                '<tr>' +
                '<td>Phone number:</td>' +
                '<td>' +
                d.phone +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Languages known :</td>' +
                '<td>' +
                d.language +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Native and Places:</td>' +
                '<td>' +
                '<input type="text" value="' + d.drop + ',' + d.places + '">' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Extra info:</td>' +
                '<td>And any further details here (images etc)...</td>' +
                '</tr>' +
                '</table>'
            );
        }

        function loadDataTable() {
            debugger
            $.ajax({
                type: "POST",
                url: "WebForm1.aspx/GetTable",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var data = JSON.parse(response.d);

                    // check whether the DataTable has already been initialized
                    if (tableInitialized) {
                        $('#example').DataTable().destroy(); // destroy the existing DataTable
                    } else {
                        tableInitialized = true;
                    }
                    var table = $('#example').DataTable({

                        data: data,
                        ordering: false,
                        columns: [

                            { data: 'person_id', visible: false },
                            {
                                data: null,
                                orderable: false,
                                className: 'select-checkbox',
                                defaultContent: '',
                            },




                            {
                                
                                className: 'dt-control',
                                orderable: false,
                                data: null,
                                defaultContent: '',
                            },



                            { data: 'name' },
                            { data: 'last_name' },
                            { data: 'phone' },
                            { data: 'gender' },
                            { data: 'language' },
                            { data: 'drop' },
                            { data: 'places' },
                            { data: 'edit',  },
                            { data: 'delete', },
                        ],
                        select: {
                            style: 'multi',
                            selector: 'td:first-child',
                            selected: true 
                        },
                        order: [[1, 'asc']],

                        dom: 'PlBfrtip',
                        columnDefs: [
                            {
                                searchPanes: {
                                    show: true
                                },
                                targets: [4]
                            }
                        ],
                        buttons: [
                         

                            {
                                extend: 'copy',
                                filename: 'Personal_details',
                                title: 'Person Details',
                                footer: true,
                                messageBottom: 'Details.'

                            },

                            {
                                extend: 'csv',
                                filename: 'Personal_details',
                                title: 'Person Details',
                                messageBottom: 'Details',
                                customize: function (doc) {
                                    doc.pageTitle = 'Person Details';
                                    doc.footer = [
                                        {
                                            text: 'Details',
                                            alignment: 'center'
                                        }
                                    ];
                                }
                            },
                            {

                                extend: 'excel',
                                filename: 'Personal_details',
                                title: 'Person Details',
                                footer: true,
                                messageBottom: 'Details.'

                            },

                            {
                                extend: 'pdf',
                                filename: 'Personal_details',
                                title: 'Person Details',
                                customize: function (doc) {
                                    doc.pageTitle = 'Person Details'; // Title for the document
                                    doc.footer = [
                                        {
                                            text: 'Person Details', // Custom text for the footer
                                            alignment: 'center'
                                        }
                                    ];
                                }
                            },
                            {
                                extend: 'print',
                                filename: 'Personal_details',
                                title: 'Person Details',
                                footer: true,
                                messageBottom: 'Personal Details.'
                            },
                           
                            
                        ],

                    });

                   
                    $('#example').on('click', 'tbody td.dt-control', function () {
                        var tr = $(this).closest('tr');
                        var row = table.row(tr);

                        if (row.child.isShown()) {
                            // This row is already open - close it
                            row.child.hide();
                        } else {
                            // Open this row only if data has been added to the DataTables
                            var data = row.data();
                            if (data && data.phone && data.language && data.drop && data.places) {
                                row.child(format(row.data())).show();
                            }
                        }
                    });
                    // Delete button should enable 
                    table.on('select', function () {
                        debugger
                        $('#delete-btn').prop('disabled', false);
                    });

                    // Disable the delete button when checkbox is not selected 
                    table.on('deselect', function () {
                        debugger
                        if (table.rows({ selected: true }).count() === 0) {
                            $('#delete-btn').prop('disabled', true);
                        }
                    });

                    // Get the ID of the checkbox wich is selcted 
                    $('#example tbody').on('click', 'td.select-checkbox', function () {
                        debugger
                        var row = $(this).closest('tr');
                        var data = table.row(row).data();
                        var personId = data['person_id'];
                        console.log(personId);
                    });

                    $('#delete-btn').click(function () {
                        debugger
                        var selectedRows = table.rows({ selected: true }).data();
                        var ids = [];

                        // Extract the IDs of selected rows
                        selectedRows.each(function (rowData) {
                            ids.push(rowData.person_id);
                        });

                        /*  Make AJAX call to delete selected rows*/
                        $.ajax({

                            type: 'POST',
                            url: 'WebForm1.aspx/DeleteDatas',
                            data: JSON.stringify({ ids: ids }),
                            contentType: 'application/json',
                            success: function (response) {
                                debugger
                                alert(response.d);
                                // Remove the selected rows from the DataTable
                                table.rows({ selected: true }).remove().draw(false);
                                $('#delete-btn').prop('disabled', true);
                               
                                $('#delete-btn').prop('disabled', true);
                            },
                            error: function () {
                                alert('An error occurred while deleting rows.');
                            },
                        });
                    });
                  
                  

                   
                },
                error: function (response) {
                    alert("Error: " + response.responseText);
                }
            });
            



        }
       
       
       
        $(document).ready(function () {
            debugger
            loadDataTable();
            dropdown();
            $("#Native").on("change", function () {
                debugger
                var district = $("#Native option:selected").text();
                getPlaces(district);
            });
            // Add the change event handler for the "Places" field
            //$("#Places").on("change", function () {
            //    debugger
            //    var places = $("#Places option:selected").text();
            //    // Perform actions based on selected value in "Places" field
            //    $('#Places').val(places);

            //});
        });

        function dropdown() {
            debugger
            $.ajax({
                type: "POST",
                url: "WebForm1.aspx/GetDropdownData",
                contentType: "application/json; charset=utf-8",

                dataType: "json",
                success: function (response) {
                    debugger
                    var dropdown = $("#Native");
                    dropdown.empty();
                    dropdown.append('<option value="select" disabled="disabled" selected="selected">select</option>');
                    $.each(response.d, function (index, item) {
                        dropdown.append('<option value="' + item.DisplayText + '">' + item.DisplayText + '</option>');

                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    debugger
                    alert("Error in dropdown:" + textStatus + ", " + errorThrown);
                }
            });
        }
        function getPlaces(district) {
            $.ajax({
                type: "POST",
                url: "WebForm1.aspx/GetPlaces",
                data: "{ 'district': '" + district + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var places = JSON.parse(data.d);
                    var select = $("#Places");
                    select.empty();
                    for (var i = 0; i < places.length; i++) {
                        var option = $("<option>").val(places[i]).text(places[i]);
                        select.append(option);
                    }
                    select.select2(); // Initialize the select2 dropdown after adding the options
                },
                error: function (xhr, status, error) {
                    console.log("Error: " + error);
                }
            });
        }

        function delet(id) {
            debugger
            var id = id;
            $.ajax({
                type: 'POST',
                url: 'WebForm1.aspx/DeletePerson',
                data: JSON.stringify({ id: id }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function () {
                    loadDataTable();

                },
                error: function (xhr, status, error) {
                    // Handle error if any
                    console.log(error);
                }
            });
        }
        function edit(id) {
            $("#auto_id").val(id);
            $.ajax({
                type: 'POST',
                url: 'WebForm1.aspx/getData',
                data: JSON.stringify({ id: id }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (result) {
                    debugger
                    var res = JSON.parse(result.d)
                    $('#Name').val(res[0].name);
                    $('#LastName').val(res[0].last_name);
                    $('#Phone').val(res[0].phone);
                    $("input[name='gender'][value='" + res[0].gender + "']").prop('checked', true);
                    var Languages = res[0].language.split(', ');
                    $('input[name="language[]"]').each(function () {
                        $(this).prop('checked', Languages.indexOf($(this).val()) > -1);
                    });
                    var drop = res[0].drop;
                    $('#Native').val(drop); // Set value for Native field

                    // Retrieve and display values for Places field when clicked for editing

                    var places = res[0].places.split(',');
                    for (i = 0; i < places.length; i++) {
                        var option = new Option(places[i], places[i], true, true)
                        $('#Places').append(option).trigger('change'); // Set values and trigger change event
                    }
                    $('#submitButton').hide();
                    $('#update-btn').show();


                },
                error: function (xhr, status, error) {
                    // Handle error if any
                    console.log(error);
                }
            });

        }

        $('#update-btn').on('click', function () {
            debugger

            $('#submitButton').show();
            $('#update-btn').hide();
            var Name = document.getElementById("Name").value;
            var LastName = document.getElementById("LastName").value;
            var Phone = document.getElementById("Phone").value;
            var gender = $('input[name=gender]:checked').val();
            var language = $('input[name="language[]"]:checked').map(function () {

                return this.value;
            }).get().join(", ");
            var row = $(this).closest('tr');
            /*  var data = $('#example').DataTable().row(row).data();*/
            var personID = $("#auto_id").val();
            var Native = $("#Native").val(); // Get the updated value of Native field
            var Places = $('#Places').select2('data').map(val => val.text).join(',');


            $.ajax({
                type: "POST",
                url: "WebForm1.aspx/UpdatePerson",
                data: JSON.stringify({ Name: Name, LastName: LastName, Phone: Phone, Gender: gender, Language: language, personID: personID, Native: Native, Places: Places }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    loadDataTable();
                    debugger
                    alert("Updated data.");
                    // Clear input fields
                    $('#Name').val('');
                    $('#LastName').val('');
                    $('#Phone').val('');
                    $('input[name=gender]').prop('checked', false);
                    $('input[name="language[]"]').prop('checked', false);
                    $('#Native').val('');
                    $('#Places').val(null).trigger('change');
                    /*  $('#example').DataTable().row(row).data(data).draw();*/
                },
                error: function () {
                    debugger
                    alert('Some error occurred!');
                }
            });
        });
    </script>
</body>
</html>
<%-- /* data.Name = $('#Name').val();
                    data.lastName = $('#LastName').val();
                    data.Phone = $('#Phone').val();
                    data.Gender = $("input[name='gender']:checked").val();

                    // Get the selected languages
                    var selectedLanguages = [];
                    $('input[name="language[]"]:checked').each(function () {
                        selectedLanguages.push($(this).val());
                    });

                    data.Language = selectedLanguages.join(', ');
                        // Update the Native field in the row
                    data.Native = Native;
                    data.Places = Places;*/--%>
