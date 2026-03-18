Table 8001523 "Temp. statistic filter"
{
    //GL2024  ID dans Nav 2009 : "8001316"
    // #4544 MB 07/05/07
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Temporary specific statistic filters by user
    //                 MB 07/05/07 + "Campaign No."

    Caption = 'Temp. statistic filter';
    // LookupPageID = 8001305;
    Permissions = TableData "Country/Region" = r,
                  TableData "Country/Region Translation" = r,
                  // TableData 12 = r,
                  TableData "Salesperson/Purchaser" = r,
                  TableData Location = r,
                  TableData "G/L Account" = r,
                  TableData Customer = r,
                  TableData Vendor = r,
                  TableData Item = r,
                  TableData "Customer Posting Group" = rimd,
                  TableData "Vendor Posting Group" = rimd,
                  TableData "Inventory Posting Group" = rimd,
                  TableData "Resource Group" = rimd,
                  TableData Resource = r,
                  // TableData 161 = r,
                  //TableData 162 = r,
                  //TableData 163 = r,
                  TableData Job = r,
                  TableData "Work Type" = r,
                  TableData "Job Posting Group" = rimd,
                  TableData "Reason Code" = rimd,
                  TableData "Gen. Business Posting Group" = rimd,
                  TableData "Gen. Product Posting Group" = rimd;

    fields
    {
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Account (G/L),Item,Resource,Employee,Resource Group';
            OptionMembers = " ","Account (G/L)",Item,Resource,Employee,"Resource Group";

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie.Type <> 0 then
                    MessageErreur;
            end;
        }
        field(6; "No."; Text[30])
        {
            Caption = 'No.';
            TableRelation = if (Type = filter("Account (G/L)")) "G/L Account"
            else
            if (Type = filter(Item)) Item
            else
            if (Type = filter(Resource)) Resource
            else
            if (Type = filter(Employee)) Employee
            else
            if (Type = filter("Resource Group")) "Resource Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."No." <> '' then
                    MessageErreur;
            end;
        }
        field(8; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item,Bank Account,Fixed Asset,Budget';
            OptionMembers = " ",Customer,Vendor,Item,"Bank Account","Fixed Asset",Budget;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Source Type" <> 0 then
                    MessageErreur;
            end;
        }
        field(9; "Source No."; Text[30])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const(Item)) Item
            else
            if ("Source Type" = filter("Bank Account")) "Bank Account"
            else
            if ("Source Type" = filter("Fixed Asset")) "Fixed Asset"
            else
            if ("Source Type" = filter(Budget)) "G/L Budget Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Source No." <> '' then
                    MessageErreur;
            end;
        }
        field(11; "Location Code"; Text[30])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Location Code" <> '' then
                    MessageErreur;
            end;
        }
        field(12; "Inventory Posting Group"; Text[30])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Inventory Posting Group" <> '' then
                    MessageErreur;
            end;
        }
        field(13; "Source Posting Group"; Text[30])
        {
            Caption = 'Source Posting Group';
            TableRelation = if ("Source Type" = filter(Customer)) "Customer Posting Group"
            else
            if ("Source Type" = filter(Vendor)) "Vendor Posting Group"
            else
            if ("Source Type" = filter(Item)) "Inventory Posting Group"
            else
            if ("Source Type" = filter("Bank Account")) "Bank Account Posting Group"
            else
            if ("Source Type" = filter("Fixed Asset")) "FA Posting Group"
            else
            if ("Source Type" = filter(Budget)) "G/L Budget Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Source Posting Group" <> '' then
                    MessageErreur;
            end;
        }
        field(14; "Gen. Bus. Posting Group"; Text[30])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Gen. Bus. Posting Group" <> '' then
                    MessageErreur;
            end;
        }
        field(15; "Gen. Prod. Posting Group"; Text[30])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Gen. Prod. Posting Group" <> '' then
                    MessageErreur;
            end;
        }
        field(16; "Salespers./Purch. Code"; Text[30])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Salespers./Purch. Code" <> '' then
                    MessageErreur;
            end;
        }
        field(17; "Global Dimension 1 Code"; Text[30])
        {
            //CaptionClass = '1,1,1';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //DimManagement.LookupDimValueCode(1,"Global Dimension 1 Code");
            end;
        }
        field(18; "Global Dimension 2 Code"; Text[30])
        {
            //CaptionClass = '1,1,2';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //DimManagement.LookupDimValueCode(2,"Global Dimension 2 Code");
            end;
        }
        field(19; "Country Code"; Text[30])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Country Code" <> '' then
                    MessageErreur;
            end;
        }
        field(35; "Fiscal year closing date"; Text[22])
        {
            Caption = 'Fiscal year closing date';

            trigger OnValidate()
            begin
                "Fiscal year closing date" := FaireFiltreDate.FaireDate("Fiscal year closing date");
                RechercheStatistique;
                if StatistiquePredefinie."Fiscal year closing date" <> '' then
                    MessageErreur;
            end;
        }
        field(37; "Business Unit Code"; Text[30])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(38; "Consol. Debit Acc."; Text[30])
        {
            Caption = 'Consol. Debit Acc.';

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Consol. Debit Acc." <> '' then
                    MessageErreur;
            end;
        }
        field(39; "Consol. Credit Acc."; Text[30])
        {
            Caption = 'Consol. Credit Acc.';

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Consol. Credit Acc." <> '' then
                    MessageErreur;
            end;
        }
        field(40; "Job No."; Text[30])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Job No." <> '' then
                    MessageErreur;
            end;
        }
        field(41; "Job Task Code"; Text[30])
        {
            Caption = 'Job Task Code';
            TableRelation = "Job Task"."Job Task No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Job Task Code" <> '' then
                    MessageErreur;
            end;
        }
        field(44; "Work Type Code"; Text[30])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Work Type Code" <> '' then
                    MessageErreur;
            end;
        }
        field(45; "Reason Code"; Text[30])
        {
            Caption = 'Reason Code';
            TableRelation = if (Type = filter(<> Employee)) "Reason Code"
            else
            if (Type = filter(Employee)) "Cause of Absence";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Reason Code" <> '' then
                    MessageErreur;
            end;
        }
        field(46; "Job Posting Group"; Text[30])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Job Posting Group" <> '' then
                    MessageErreur;
            end;
        }
        field(47; "Resource Group No."; Text[30])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(48; "Person Responsible"; Text[30])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(57; "Campaign No."; Text[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;

            trigger OnValidate()
            var
                TempDocDim: Record "Gen. Jnl. Dim. Filter" temporary;
            begin
            end;
        }
        field(60; "Item criteria 1"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99030';
            Caption = 'Item criteria 1';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(61; "Item criteria 2"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99031';
            Caption = 'Item criteria 2';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(62; "Item criteria 3"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99032';
            Caption = 'Item criteria 3';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(63; "Item criteria 4"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99033';
            Caption = 'Item criteria 4';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(64; "Item criteria 5"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99035';
            Caption = 'Item criteria 5';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(65; "Item criteria 6"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99036';
            Caption = 'Item criteria 6';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(66; "Item criteria 7"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99036';
            Caption = 'Item criteria 7';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(67; "Item criteria 8"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99037';
            Caption = 'Item criteria 8';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(68; "Item criteria 9"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99038';
            Caption = 'Item criteria 9';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69; "Item criteria 10"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99039';
            Caption = 'Item criteria 10';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(70; "Customer criteria 1"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99003';
            Caption = 'Customer criteria 1';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(71; "Customer criteria 2"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99004';
            Caption = 'Customer criteria 2';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(72; "Customer criteria 3"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99005';
            Caption = 'Customer criteria 3';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(73; "Customer criteria 4"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99006';
            Caption = 'Customer criteria 4';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(74; "Customer criteria 5"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99007';
            Caption = 'Customer criteria 5';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(75; "Customer criteria 6"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99008';
            Caption = 'Customer criteria 6';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(76; "Customer criteria 7"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99009';
            Caption = 'Customer criteria 7';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(77; "Customer criteria 8"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99010';
            Caption = 'Customer criteria 8';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(78; "Customer criteria 9"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99011';
            Caption = 'Customer criteria 9';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(79; "Customer criteria 10"; Text[30])
        {
            Caption = 'Customer criteria 10';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; "Job criteria 1"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99090';
            Caption = 'Job criteria 1';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(90; "Back disc./commission rule No."; Text[30])
        {
            Caption = 'Back discount/commission rule No.';
            TableRelation = "Discount Rule"."No." where("Discount and comm. type" = filter("Back discount" | Commission));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Back disc./commission rule No." <> '' then
                    MessageErreur;
            end;
        }
        field(91; "Job criteria 2"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99091';
            Caption = 'Job criteria 2';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Job criteria 3"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99092';
            Caption = 'Job criteria 3';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(93; "Job criteria 4"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99093';
            Caption = 'Job criteria 4';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(94; "Job criteria 5"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99094';
            Caption = 'Job criteria 5';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(95; "Job criteria 6"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99095';
            Caption = 'Job criteria 6';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(96; "Job criteria 7"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99096';
            Caption = 'Job criteria 7';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(97; "Job criteria 8"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99097';
            Caption = 'Job criteria 8';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(98; "Job criteria 9"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99098';
            Caption = 'Job criteria 9';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(99; "Job criteria 10"; Text[20])
        {
            //CaptionClass = '8001400,3,8001302,99099';
            Caption = 'Job criteria 10';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(110; "1st sort level"; Text[30])
        {
            Caption = '1st sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("1st sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "1st sort level") then begin
                    "Sort 1 : start pos." := 1;
                    "Sort 1 : length" := Critere.Length;
                end else begin
                    "Sort 1 : start pos." := 0;
                    "Sort 1 : length" := 0;
                    "Sort 1 : skip page" := false;
                end;
            end;
        }
        field(111; "Sort 1 : start pos."; Integer)
        {
            Caption = 'Sort 1 : start pos.';
        }
        field(112; "Sort 1 : length"; Integer)
        {
            Caption = 'Sort 1 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "1st sort level") and ("Sort 1 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(113; "Sort 1 : skip page"; Boolean)
        {
            Caption = 'Sort 1 : skip page';
        }
        field(114; "Sort 1 : line before total"; Option)
        {
            Caption = 'Sort 1 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(115; "Sort 1 : line after total"; Option)
        {
            Caption = 'Sort 1 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(120; "2nd sort level"; Text[30])
        {
            Caption = '2nd sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("2nd sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "2nd sort level") then begin
                    "Sort 2 : start pos." := 1;
                    "Sort 2 : length" := Critere.Length;
                end else begin
                    "Sort 2 : start pos." := 0;
                    "Sort 2 : length" := 0;
                    "Sort 2 : skip page" := false;
                end;
            end;
        }
        field(121; "Sort 2 : start pos."; Integer)
        {
            Caption = 'Sort 2 : start pos.';
        }
        field(122; "Sort 2 : length"; Integer)
        {
            Caption = 'Sort 2 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "2nd sort level") and ("Sort 2 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(123; "Sort 2 : skip page"; Boolean)
        {
            Caption = 'Sort 2 : skip page';
        }
        field(124; "Sort 2 : line before total"; Option)
        {
            Caption = 'Sort 2 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(125; "Sort 2 : line after total"; Option)
        {
            Caption = 'Sort 2 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(130; "3th sort level"; Text[30])
        {
            Caption = '3rd sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("3th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "3th sort level") then begin
                    "Sort 3 : start pos." := 1;
                    "Sort 3 : length" := Critere.Length;
                end else begin
                    "Sort 3 : start pos." := 0;
                    "Sort 3 : length" := 0;
                    "Sort 3 : skip page" := false;
                end;
            end;
        }
        field(131; "Sort 3 : start pos."; Integer)
        {
            Caption = 'Sort 3 : start pos.';
        }
        field(132; "Sort 3 : length"; Integer)
        {
            Caption = 'Sort 3 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "3th sort level") and ("Sort 3 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(133; "Sort 3 : skip page"; Boolean)
        {
            Caption = 'Sort 3 : skip page';
        }
        field(134; "Sort 3 : line before total"; Option)
        {
            Caption = 'Sort 3 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(135; "Sort 3 : line after total"; Option)
        {
            Caption = 'Sort 3 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(140; "4th sort level"; Text[30])
        {
            Caption = '4th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("4th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "4th sort level") then begin
                    "Sort 4 : start pos." := 1;
                    "Sort 4 : length" := Critere.Length;
                end else begin
                    "Sort 4 : start pos." := 0;
                    "Sort 4 : length" := 0;
                    "Sort 4 : skip page" := false;
                end;
            end;
        }
        field(141; "Sort 4 : start pos."; Integer)
        {
            Caption = 'Sort 4 : start pos.';
        }
        field(142; "Sort 4 : length"; Integer)
        {
            Caption = 'Sort 4 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "4th sort level") and ("Sort 4 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(143; "Sort 4 : skip page"; Boolean)
        {
            Caption = 'Sort 4 : skip page';
        }
        field(144; "Sort 4 : line before total"; Option)
        {
            Caption = 'Sort 4 :';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(145; "Sort 4 : line after total"; Option)
        {
            Caption = 'Sort 4 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(150; "5th sort level"; Text[30])
        {
            Caption = '5th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("5th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "5th sort level") then begin
                    "Sort 5 : start pos." := 1;
                    "Sort 5 : length" := Critere.Length;
                end else begin
                    "Sort 5 : start pos." := 0;
                    "Sort 5 : length" := 0;
                    "Sort 5 : skip page" := false;
                end;
            end;
        }
        field(151; "Sort 5 : start pos."; Integer)
        {
            Caption = 'Sort 5 : start pos.';
        }
        field(152; "Sort 5 : length"; Integer)
        {
            Caption = 'Sort 5 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "5th sort level") and ("Sort 5 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(153; "Sort 5 : skip page"; Boolean)
        {
            Caption = 'Sort 5 : skip page';
        }
        field(154; "Sort 5 : line before total"; Option)
        {
            Caption = 'Sort 5 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(155; "Sort 5 : line after total"; Option)
        {
            Caption = 'Sort 5 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(160; "6th sort level"; Text[30])
        {
            Caption = '6th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("6th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "6th sort level") then begin
                    "Sort 6 : start pos." := 1;
                    "Sort 6 : length" := Critere.Length;
                end else begin
                    "Sort 6 : start pos." := 0;
                    "Sort 6 : length" := 0;
                    "Sort 6 : skip page" := false;
                end;
            end;
        }
        field(161; "Sort 6 : start pos."; Integer)
        {
            Caption = 'Sort 6 : start pos.';
        }
        field(162; "Sort 6 : length"; Integer)
        {
            Caption = 'Sort 6 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "6th sort level") and ("Sort 6 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(163; "Sort 6 : skip page"; Boolean)
        {
            Caption = 'Sort 6 : skip page';
        }
        field(164; "Sort 6 : line before total"; Option)
        {
            Caption = 'Sort 6 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(165; "Sort 6 : line after total"; Option)
        {
            Caption = 'Sort 6 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(170; "7th sort level"; Text[30])
        {
            Caption = '7th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("7th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "7th sort level") then begin
                    "Sort 7 : start pos." := 1;
                    "Sort 7 : length" := Critere.Length;
                end else begin
                    "Sort 7 : start pos." := 0;
                    "Sort 7 : length" := 0;
                    "Sort 7 : skip page" := false;
                end;
            end;
        }
        field(171; "Sort 7 : start pos."; Integer)
        {
            Caption = 'Sort 7 : start pos.';
        }
        field(172; "Sort 7 : length"; Integer)
        {
            Caption = 'Sort 7 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "7th sort level") and ("Sort 7 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(173; "Sort 7 : skip page"; Boolean)
        {
            Caption = 'Sort 7 : skip page';
        }
        field(174; "Sort 7 : line before total"; Option)
        {
            Caption = 'Sort 7 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(175; "Sort 7 : line after total"; Option)
        {
            Caption = 'Sort 7 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(180; "8th sort level"; Text[30])
        {
            Caption = '8th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("8th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "8th sort level") then begin
                    "Sort 8 : start pos." := 1;
                    "Sort 8 : length" := Critere.Length;
                end else begin
                    "Sort 8 : start pos." := 0;
                    "Sort 8 : length" := 0;
                    "Sort 8 : skip page" := false;
                end;
            end;
        }
        field(181; "Sort 8 : start pos."; Integer)
        {
            Caption = 'Sort 8 : start pos.';
        }
        field(182; "Sort 8 : length"; Integer)
        {
            Caption = 'Sort 8 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "8th sort level") and ("Sort 8 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(183; "Sort 8 : skip page"; Boolean)
        {
            Caption = 'Sort 8 : skip page';
        }
        field(184; "Sort 8 : line before total"; Option)
        {
            Caption = 'Sort 8 :';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(185; "Sort 8 : line after total"; Option)
        {
            Caption = 'Sort 8 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(190; "9th sort level"; Text[30])
        {
            Caption = '9th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("9th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "9th sort level") then begin
                    "Sort 9 : start pos." := 1;
                    "Sort 9 : length" := Critere.Length;
                end else begin
                    "Sort 9 : start pos." := 0;
                    "Sort 9 : length" := 0;
                    "Sort 9 : skip page" := false;
                end;
            end;
        }
        field(191; "Sort 9 : start pos."; Integer)
        {
            Caption = 'Sort 9 : start pos.';
        }
        field(192; "Sort 9 : length"; Integer)
        {
            Caption = 'Sort 9 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "9th sort level") and ("Sort 9 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(193; "Sort 9 : skip page"; Boolean)
        {
            Caption = 'Sort 9 : skip page';
        }
        field(194; "Sort 9 : line before total"; Option)
        {
            Caption = 'Sort 9 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(195; "Sort 9 : line after total"; Option)
        {
            Caption = 'Sort 9 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(200; "10th sort level"; Text[30])
        {
            Caption = '10th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                RechercheStatistique;
                RechercheTri("10th sort level");
                if Critere.Get(Critere.Type::"Sort criteria", "10th sort level") then begin
                    "Sort 10 : start pos." := 1;
                    "Sort 10 : length" := Critere.Length;
                end else begin
                    "Sort 10 : start pos." := 0;
                    "Sort 10 : length" := 0;
                    "Sort 10 : skip page" := false;
                end;
            end;
        }
        field(201; "Sort 10 : start pos."; Integer)
        {
            Caption = 'Sort 10 : start pos.';
        }
        field(202; "Sort 10 : length"; Integer)
        {
            Caption = 'Sort 10 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "10th sort level") and ("Sort 10 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(203; "Sort 10 : skip page"; Boolean)
        {
            Caption = 'Sort 10 : skip page';
        }
        field(204; "Sort 10 : line before total"; Option)
        {
            Caption = 'Sort 10 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(205; "Sort 10 : line after total"; Option)
        {
            Caption = 'Sort 10 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(300; "Item Charge No."; Text[30])
        {
            Caption = 'Item Charge No.';
            TableRelation = "Item Charge";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(301; "Variant Code"; Text[30])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = filter(Item)) "Item Variant".Code where("Item No." = field("No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(303; "Return Reason Code"; Text[30])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(310; "Manufacturer Code"; Text[30])
        {
            Caption = 'Manufacturer Code';
            TableRelation = Manufacturer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(311; "Item Category Code"; Text[30])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(312; "Product Group Code"; Text[30])
        {
            Caption = 'Product Group Code';
            //GL2024     TableRelation = "Product Group".Code where("Item Category Code" = field("Item Category Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            //GL2024     ValidateTableRelation = false;
        }
        field(313; "Service Item Group"; Text[30])
        {
            Caption = 'Service Item Group';
            TableRelation = "Service Item Group".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(500; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(501; Name; Text[80])
        {
            Caption = 'Name';
        }
        field(510; "Sort criteria"; Code[10])
        {
            Caption = 'Sort criteria';
            TableRelation = "Statistic sort criteria".Code where(Type = filter("Tri statistique"));

            trigger OnValidate()
            begin
                TriStatistique.Init;
                if TriStatistique.Get(TriStatistique.Type::"Tri statistique", "Sort criteria") or ("Sort criteria" = '') then begin
                    Validate("1st sort level", TriStatistique."1st sort level");
                    "Sort 1 : start pos." := TriStatistique."Sort 1 : start pos.";
                    "Sort 1 : length" := TriStatistique."Sort 1 : length";
                    "Sort 1 : skip page" := TriStatistique."Sort 1 : skip page";

                    Validate("2nd sort level", TriStatistique."2nd sort level");
                    "Sort 2 : start pos." := TriStatistique."Sort 2 : start pos.";
                    "Sort 2 : length" := TriStatistique."Sort 2 : length";
                    "Sort 2 : skip page" := TriStatistique."Sort 2 : skip page";

                    Validate("3th sort level", TriStatistique."3rd sort level");
                    "Sort 3 : start pos." := TriStatistique."Sort 3 : start pos.";
                    "Sort 3 : length" := TriStatistique."Sort 3 : length";
                    "Sort 3 : skip page" := TriStatistique."Sort 3 : skip page";

                    Validate("4th sort level", TriStatistique."4th sort level");
                    "Sort 4 : start pos." := TriStatistique."Sort 4 : start pos.";
                    "Sort 4 : length" := TriStatistique."Sort 4 : length";
                    "Sort 4 : skip page" := TriStatistique."Sort 4 : skip page";

                    Validate("5th sort level", TriStatistique."5th sort level");
                    "Sort 5 : start pos." := TriStatistique."Sort 5 : start pos.";
                    "Sort 5 : length" := TriStatistique."Sort 5 : length";
                    "Sort 5 : skip page" := TriStatistique."Sort 5 : skip page";

                    Validate("6th sort level", TriStatistique."6th sort level");
                    "Sort 6 : start pos." := TriStatistique."Sort 6 : start pos.";
                    "Sort 6 : length" := TriStatistique."Sort 6 : length";
                    "Sort 6 : skip page" := TriStatistique."Sort 6 : skip page";

                    Validate("7th sort level", TriStatistique."7th sort level");
                    "Sort 7 : start pos." := TriStatistique."Sort 7 : start pos.";
                    "Sort 7 : length" := TriStatistique."Sort 7 : length";
                    "Sort 7 : skip page" := TriStatistique."Sort 7 : skip page";

                    Validate("8th sort level", TriStatistique."8th sort level");
                    "Sort 8 : start pos." := TriStatistique."Sort 8 : start pos.";
                    "Sort 8 : length" := TriStatistique."Sort 8 : length";
                    "Sort 8 : skip page" := TriStatistique."Sort 8 : skip page";

                    Validate("9th sort level", TriStatistique."9th sort level");
                    "Sort 9 : start pos." := TriStatistique."Sort 9 : start pos.";
                    "Sort 9 : length" := TriStatistique."Sort 9 : length";
                    "Sort 9 : skip page" := TriStatistique."Sort 9 : skip page";

                    Validate("10th sort level", TriStatistique."10th sort level");
                    "Sort 10 : start pos." := TriStatistique."Sort 10 : start pos.";
                    "Sort 10 : length" := TriStatistique."Sort 10 : length";
                    "Sort 10 : skip page" := TriStatistique."Sort 10 : skip page";
                end else
                    if "Sort criteria" <> '' then
                        Error(Error2, "Sort criteria");
                RechercheStatistique;
            end;
        }
        field(511; "Column Layout Name"; Code[10])
        {
            Caption = 'Column Layout Name';
            TableRelation = "Column style name";
        }
        field(512; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(1001; "Free field 1"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99041';
            Caption = 'Free field 1';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1001));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 1" <> '' then
                    MessageErreur;
            end;
        }
        field(1002; "Free field 2"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99042';
            Caption = 'Free field 2';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1002));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 2" <> '' then
                    MessageErreur;
            end;
        }
        field(1003; "Free field 3"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99043';
            Caption = 'Free field 3';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1003));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 3", "Free field 3");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 3" <> '' then
                    MessageErreur;
            end;
        }
        field(1004; "Free field 4"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99044';
            Caption = 'Free field 4';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1004));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 4", "Free field 4");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 4" <> '' then
                    MessageErreur;
            end;
        }
        field(1005; "Free field 5"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99045';
            Caption = 'Free field 5';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1005));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 5", "Free field 5");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 5" <> '' then
                    MessageErreur;
            end;
        }
        field(1006; "Free field 6"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99046';
            Caption = 'Free field 6';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1006));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 6", "Free field 6");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 6" <> '' then
                    MessageErreur;
            end;
        }
        field(1007; "Free field 7"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99047';
            Caption = 'Free field 7';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1007));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 7", "Free field 7");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 7" <> '' then
                    MessageErreur;
            end;
        }
        field(1008; "Free field 8"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99048';
            Caption = 'Free field 8';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1008));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 8", "Free field 8");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 8" <> '' then
                    MessageErreur;
            end;
        }
        field(1009; "Free field 9"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99049';
            Caption = 'Free field 9';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1009));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 9", "Free field 9");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 9" <> '' then
                    MessageErreur;
            end;
        }
        field(1010; "Free field 10"; Text[30])
        {
            //CaptionClass = '8001400,3,8001302,99050';
            Caption = 'Free field 10';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1010));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 10", "Free field 10");
            end;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free field 10" <> '' then
                    MessageErreur;
            end;
        }
        field(1011; "Free date 1"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99061';
            Caption = 'Free date 1';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 1" := FaireFiltreDate.FaireDate("Free date 1");
                RechercheStatistique;
                if StatistiquePredefinie."Free date 1" <> '' then
                    MessageErreur;
            end;
        }
        field(1012; "Free date 2"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99062';
            Caption = 'Free date 2';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 2" := FaireFiltreDate.FaireDate("Free date 2");
                RechercheStatistique;
                if StatistiquePredefinie."Free date 2" <> '' then
                    MessageErreur;
            end;
        }
        field(1013; "Free date 3"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99063';
            Caption = 'Free date 3';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 3" := FaireFiltreDate.FaireDate("Free date 3");
                RechercheStatistique;
                if StatistiquePredefinie."Free date 3" <> '' then
                    MessageErreur;
            end;
        }
        field(1014; "Free date 4"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99064';
            Caption = 'Free date 4';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 4" := FaireFiltreDate.FaireDate("Free date 4");
                RechercheStatistique;
                if StatistiquePredefinie."Free date 4" <> '' then
                    MessageErreur;
            end;
        }
        field(1015; "Free date 5"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99065';
            Caption = 'Free date 5';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 5" := FaireFiltreDate.FaireDate("Free date 5");
                RechercheStatistique;
                if StatistiquePredefinie."Free date 5" <> '' then
                    MessageErreur;
            end;
        }
        field(1021; "Free boolean 1"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99071';
            Caption = 'Free boolean 1';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free boolean 1" <> 0 then
                    MessageErreur;
            end;
        }
        field(1022; "Free boolean 2"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99072';
            Caption = 'Free boolean 2';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free boolean 2" <> 0 then
                    MessageErreur;
            end;
        }
        field(1023; "Free boolean 3"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99073';
            Caption = 'Free boolean 3';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free boolean 3" <> 0 then
                    MessageErreur;
            end;
        }
        field(1024; "Free boolean 4"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99074';
            Caption = 'Free boolean 4';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free boolean 4" <> 0 then
                    MessageErreur;
            end;
        }
        field(1025; "Free boolean 5"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99075';
            Caption = 'Free boolean 5';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                RechercheStatistique;
                if StatistiquePredefinie."Free boolean 5" <> 0 then
                    MessageErreur;
            end;
        }
        field(30001; "Dimension 1 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(1);
            Caption = 'Dimension 1 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 1 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 1 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30002; "Dimension 2 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(2);
            Caption = 'Dimension 2 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 2 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 2 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30003; "Dimension 3 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(3);
            Caption = 'Dimension 3 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 3 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 3 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30004; "Dimension 4 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(4);
            Caption = 'Dimension 4 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 4 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 4 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30005; "Dimension 5 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(5);
            Caption = 'Dimension 5 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 5 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 5 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30006; "Dimension 6 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(6);
            Caption = 'Dimension 6 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 6 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 6 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30007; "Dimension 7 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(7);
            Caption = 'Dimension 7 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 7 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 7 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30008; "Dimension 8 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(8);
            Caption = 'Dimension 8 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 8 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 8 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30009; "Dimension 9 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(9);
            Caption = 'Dimension 9 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 9 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 9 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30010; "Dimension 10 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(10);
            Caption = 'Dimension 10 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 10 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 10 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30011; "Dimension 11 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(11);
            Caption = 'Dimension 11 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 11 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 11 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30012; "Dimension 12 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(12);
            Caption = 'Dimension 12 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 12 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 12 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30013; "Dimension 13 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(13);
            Caption = 'Dimension 13 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 13 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 13 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30014; "Dimension 14 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(14);
            Caption = 'Dimension 14 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 14 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 14 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30015; "Dimension 15 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(15);
            Caption = 'Dimension 15 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 15 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 15 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30016; "Dimension 16 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(16);
            Caption = 'Dimension 16 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 16 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 16 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30017; "Dimension 17 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(17);
            Caption = 'Dimension 17 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 17 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 17 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30018; "Dimension 18 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(18);
            Caption = 'Dimension 18 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 18 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 18 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30019; "Dimension 19 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(19);
            Caption = 'Dimension 19 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 19 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 19 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30020; "Dimension 20 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(20);
            Caption = 'Dimension 20 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 20 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 20 Value Code" := DimValue.Code;
                end;
            end;
        }
    }

    keys
    {
        key(STG_Key1; "User ID", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StatisticAggregate: Record "Statistic aggregate";
        StatisticsSetup: Record "Statistics setup";
        Critere: Record "Statistic criteria";
        TriStatistique: Record "Statistic sort criteria";
        StatistiquePredefinie: Record "Standard statistic";
        //DYS
        // MembreSecurite: Record 2000000003;
        DimValue: Record "Dimension Value";
        CleTri: array[10] of Text[30];
        SautDePage: array[10] of Boolean;
        SeparateurAvant: array[10] of Option Aucun,"Ligne blanche","Trait fin","Trait normal","Trait épais";
        SeparateurApres: array[10] of Option Aucun,"Ligne blanche","Trait fin","Trait normal","Trait épais";
        PositionDebut: array[10] of Integer;
        Longueur: array[10] of Integer;
        Error1: label 'Max length is %1 character for this field';
        Error2: label '%1 code not defined';
        Error3: label 'You can''t use this sort criteria';
        Error4: label 'This value can''t be updated';
        //GL2024   Error5: ;
        //GL2024    Error6: ;
        FaireFiltreDate: Codeunit MakeDateFilter;
        wTableRelation: Codeunit TableRelation;
        Text001: label '1,6,,Dimension 1 Value Code';
        Text002: label '1,6,,Dimension 2 Value Code';
        Text003: label '1,6,,Dimension 3 Value Code';
        Text004: label '1,6,,Dimension 4 Value Code';
        Text005: label '1,6,,Dimension 5 Value Code';
        Text006: label '1,6,,Dimension 6 Value Code';
        Text007: label '1,6,,Dimension 7 Value Code';
        Text008: label '1,6,,Dimension 8 Value Code';
        Text009: label '1,6,,Dimension 9 Value Code';
        Text010: label '1,6,,Dimension 10 Value Code';
        Text011: label '1,6,,Dimension 11 Value Code';
        Text012: label '1,6,,Dimension 12 Value Code';
        Text013: label '1,6,,Dimension 13 Value Code';
        Text014: label '1,6,,Dimension 14 Value Code';
        Text015: label '1,6,,Dimension 15 Value Code';
        Text016: label '1,6,,Dimension 16 Value Code';
        Text017: label '1,6,,Dimension 17 Value Code';
        Text018: label '1,6,,Dimension 18 Value Code';
        Text019: label '1,6,,Dimension 19 Value Code';
        Text020: label '1,6,,Dimension 20 Value Code';


    procedure RechercheStatistique()
    begin
        if (StatistiquePredefinie.Code) <> Code then
            StatistiquePredefinie.Get(Code);
    end;


    procedure RechercheTri(TypeTri: Text[30])
    var
        i: Integer;
        Trouve: Boolean;
    begin
        //DYS FONCTION OBSOLET
        // if (MembreSecurite.WritePermission) or (StrPos(COMPANYNAME, 'CRONUS') = 1) then
        //     exit;

        // On charge en mémoire les critères de la stat prédéfinie
        if CleTri[1] = '' then
            i := 0;
        with StatistiquePredefinie do repeat
                                          i := i + 1;
                                          CleTri[1] := "1st sort level";
                                          CleTri[2] := "2nd sort level";
                                          CleTri[3] := "3rd sort level";
                                          CleTri[4] := "4th sort level";
                                          CleTri[5] := "5th sort level";
                                          CleTri[6] := "6th sort level";
                                          CleTri[7] := "1st sort level";
                                          CleTri[8] := "7th sort level";
                                          CleTri[9] := "9th sort level";
                                          CleTri[10] := "10th sort level";
            until i = 10;

        // On regarde si le tri choisi correspond bien à l'un des tris prédéfinis
        Trouve := false;
        i := 0;
        repeat
            i := i + 1;
            if TypeTri = CleTri[i] then
                Trouve := true;
        until i = 10;

        if not Trouve then
            Error(Error3);
    end;


    procedure MessageErreur()
    begin
        //DYS fonction obsolet
        // if (not MembreSecurite.WritePermission) and ((StrPos(COMPANYNAME, 'CRONUS') <> 1)) then
        //     Error(Error4);
    end;


    procedure GetCaptionClass(AnalysisViewDimType: Integer): Text[250]
    begin
        StatisticsSetup.Get;
        case AnalysisViewDimType of
            1:
                begin
                    if StatisticsSetup."Dimension 1 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 1 Code")
                    else
                        exit(Text001);
                end;
            2:
                begin
                    if StatisticsSetup."Dimension 2 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 2 Code")
                    else
                        exit(Text002);
                end;
            3:
                begin
                    if StatisticsSetup."Dimension 3 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 3 Code")
                    else
                        exit(Text003);
                end;
            4:
                begin
                    if StatisticsSetup."Dimension 4 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 4 Code")
                    else
                        exit(Text004);
                end;
            5:
                begin
                    if StatisticsSetup."Dimension 5 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 5 Code")
                    else
                        exit(Text005);
                end;
            6:
                begin
                    if StatisticsSetup."Dimension 6 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 6 Code")
                    else
                        exit(Text006);
                end;
            7:
                begin
                    if StatisticsSetup."Dimension 7 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 7 Code")
                    else
                        exit(Text007);
                end;
            8:
                begin
                    if StatisticsSetup."Dimension 8 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 8 Code")
                    else
                        exit(Text008);
                end;
            9:
                begin
                    if StatisticsSetup."Dimension 9 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 9 Code")
                    else
                        exit(Text009);
                end;
            10:
                begin
                    if StatisticsSetup."Dimension 10 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 10 Code")
                    else
                        exit(Text010);
                end;
            11:
                begin
                    if StatisticsSetup."Dimension 11 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 11 Code")
                    else
                        exit(Text011);
                end;
            12:
                begin
                    if StatisticsSetup."Dimension 12 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 12 Code")
                    else
                        exit(Text012);
                end;
            13:
                begin
                    if StatisticsSetup."Dimension 13 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 13 Code")
                    else
                        exit(Text013);
                end;
            14:
                begin
                    if StatisticsSetup."Dimension 14 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 14 Code")
                    else
                        exit(Text014);
                end;
            15:
                begin
                    if StatisticsSetup."Dimension 15 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 15 Code")
                    else
                        exit(Text015);
                end;
            16:
                begin
                    if StatisticsSetup."Dimension 16 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 16 Code")
                    else
                        exit(Text016);
                end;
            17:
                begin
                    if StatisticsSetup."Dimension 17 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 17 Code")
                    else
                        exit(Text017);
                end;
            18:
                begin
                    if StatisticsSetup."Dimension 18 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 18 Code")
                    else
                        exit(Text018);
                end;
            19:
                begin
                    if StatisticsSetup."Dimension 19 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 19 Code")
                    else
                        exit(Text019);
                end;
            20:
                begin
                    if StatisticsSetup."Dimension 20 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 20 Code")
                    else
                        exit(Text020);
                end;
        end;
    end;


    procedure LookUpFreeField(pFieldRef: Text[50]; var pFieldValue: Text[50])
    var
        lTable: Integer;
        lField: Integer;
        lCode: Code[20];
        lTableTxt: Text[30];
        lFieldTxt: Text[30];
    begin
        if StrPos(pFieldRef, '.') > 1 then begin
            lTableTxt := CopyStr(pFieldRef, 1, StrPos(pFieldRef, '.') - 1);
            lFieldTxt := CopyStr(pFieldRef, StrPos(pFieldRef, '.') + 1);
        end;
        Evaluate(lTable, lTableTxt);
        Evaluate(lField, lFieldTxt);
        wTableRelation.LookUp(lTable, lField, lCode);
        pFieldValue := Format(lCode);
    end;
}

