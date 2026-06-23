// Source and remove unused column
    Source = Excel.Workbook(
        File.Contents("C:\Users\nmeri\OneDrive\Documentos\raw_data.xlsx"),
        null,
        true
    ),
    DataSource_Table = Source{[Item="DataSourceHoneywell",Kind="Table"]}[Data],
    #"Removed Columns" = Table.RemoveColumns(DataSource_Table,{"Amount USD"}),

    // Rename columns 
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{
        {"Opportunity ID", "Opportunity_ID"},
        {"Stage Duration", "Stage_Duration"},
        {"Opportunity Owner", "Opportunity_Owner"},
        {"Opportunity Grade", "Opportunity_Grade"},
        {"Probability (%)", "Probability"},
        {"Amount Currency", "Amount_Currency"},
        {"Created Date", "Created_Date"},
        {"Primary Reason", "Primary_Reason"}
    }),

    // Type columns 
    #"Changed Types" = Table.TransformColumnTypes(#"Renamed Columns",{
        {"Opportunity_ID", Int64.Type},
        {"Closed", Int64.Type},
        {"Won", Int64.Type},
        {"Stage", type text},
        {"Stage_Duration", Int64.Type},
        {"Segments", type text},
        {"Region", type text},
        {"Opportunity_Owner", type text},
        {"Opportunity_Grade", type text},
        {"Probability", type number},
        {"Age", Int64.Type},
        {"Amount_Currency", type text},
        {"Amount", type number},
        {"Created_Date", type date},
        {"Primary_Reason", type text},
        {"Country", type text}
    }),

    // Add boolean columns derived from Closed/Won 
    #"Added Closed_boolean" = Table.AddColumn(
        #"Changed Types",
        "Closed_boolean",
        each [Closed] = 1,
        type logical
    ),
    #"Added Won_boolean" = Table.AddColumn(
        #"Added Closed_boolean",
        "Won_boolean",
        each [Won] = 1,
        type logical
    ),

    // Clean text columns
    #"Cleaned Text" = Table.TransformColumns(#"Added Won_boolean", {
        // Codes / identifiers
        {"Amount_Currency", each Text.Upper(Text.Trim(Text.Clean(Text.Select(_, {"A".."Z"})))), type text},
        {"Region", each Text.Upper(Text.Trim(Text.Clean(_))), type text},
        {"Opportunity_Owner", each Text.Upper(Text.Trim(Text.Clean(_))), type text},
        {"Opportunity_Grade", each Text.Upper(Text.Trim(Text.Clean(_))), type text},

        // Descriptive labels
        {"Stage", each Text.Trim(Text.Clean(_)), type text},
        {"Segments", each Text.Trim(Text.Clean(_)), type text},
        {"Primary_Reason", each Text.Trim(Text.Clean(_)), type text},

        // Natural language
        {"Country", each Text.Proper(Text.Trim(Text.Clean(_))), type text}
    }),

    // Handle blank Opportunity Grade explicitly
    #"Handled Blank Opportunity Grade" =
        Table.ReplaceValue(
            #"Cleaned Text",
            "",
            "UNRATED",
            Replacer.ReplaceValue,
            {"Opportunity_Grade"}
        )

in
    #"Handled Blank Opportunity Grade"
