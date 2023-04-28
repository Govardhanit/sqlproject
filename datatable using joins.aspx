<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="datatable using joins.aspx.cs" Inherits="sqlproject1.datatabtable_using_joins" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
</head>
<body>
    <form id="form1" runat="server">
          <div class="container mt-5">
            <table id="example" class="table table-striped" style="width: 105%">
                <thead>
                    <tr>
                        <th></th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Years_of_experience</th>
                        <th>CurrentSalary</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- table data will be generated dynamically here -->
                </tbody>
            </table>
        </div>
    </form>
</body> 
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <!--DataTables-->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
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
        function format(d) {
            // `d` is the original data object for the row
            return (
                '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
                '<tr>' +
                '<td>Name:</td>' +
                '<td>' +
                d.Name +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Department :</td>' +
                '<td>' +
                d.Department +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Experience&Salary:</td>' +
                '<td>' +
                '<input type="text" value="' + d.Year_of_experience + ',' + d.Current_salary + '">' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>Extra info:</td>' +
                '<td>And any further details here (images etc)...</td>' +
                '</tr>' +
                '</table>'
            );
        }

        $(document).ready(function () {
            var table = $('#example').DataTable({
                columns: [
                    {
                        className: 'dt-control',
                        orderable: false,
                        data: null,
                        defaultContent: '',
                    },
                    { data: 'Name' },
                    { data: 'Department' },
                    { data: 'Year_of_experience' },
                    { data: 'Current_salary' },
                ],
               
            });

            $.ajax({
                type: 'POST',
                url: 'datatable using joins.aspx/Getdatabase',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    alert('Success');
                    var data = response.d;
                    table.clear().rows.add(data).draw(); // Update the DataTable with the retrieved data

                    $('#example').on('click', 'tbody td.dt-control', function () {
                        var tr = $(this).closest('tr');
                        var row = table.row(tr);

                        if (row.child.isShown()) {
                            // This row is already open - close it
                            row.child.hide();
                        } else {
                            // Open this row only if data has been added to the DataTables
                            var data = row.data();
                            if (data && data.Name && data.Department && data.Year_of_experience && data.Current_salary) {
                                row.child(format(row.data())).show();
                            }
                        }
                    });
                },
                error: function (response) {
                    console.log(response);
                },
            });
        });



    </script>
</html>
