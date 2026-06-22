let
    Source = Excel.Workbook(File.Contents("C:\Users\nmeri\OneDrive\Documentos\raw_data.xlsx"),

    Table1_Table = Source{[Item="Table1",Kind="Table"]}[Data],

    // Rename columns
    #"Renamed Columns" = Table.RenameColumns(Table1_Table,{
        {"Opportunity Currency", "Opportunity_Currency"},
        {"Exchange Rate", "Exchange_Rate"}
    }),

    // Change types
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{
        {"Opportunity_Currency", type text},
        {"Exchange_Rate", type number}
    })
in
    #"Changed Type"
