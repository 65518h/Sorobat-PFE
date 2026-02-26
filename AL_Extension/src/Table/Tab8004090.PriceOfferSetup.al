Table 8004090 "Price Offer Setup"
{
    // //+OFF+OFFRE GESWAY 17/10/02 Table Paramètres offres de prix fournisseur
    //                        06/11/02 Ajout champ "Default Quote Vendor"
    //                        31/01/03 Ajout champs "Select Vendor From"
    //                        15/09/03 Supprime champ "Excel Sheet Name"
    //                                 Ajout champs "Outlook Send Mail FolderID",
    //                                   "Outlook Send Mail Folder Path","Outlook Open Dialog"
    // 
    // //+OFF+REMISE GESWAY 17/10/02 Ajout champs "Historic Date Calculation"

    Caption = 'Price Offer Setup';
    //LookupPageID = 8004090;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Export Folder"; Text[250])
        {
            Caption = 'Export Folder';

            trigger OnValidate()
            begin
                "Export Folder" := FolderCheck("Export Folder");
            end;
        }
        field(3; "History Folder"; Text[250])
        {
            Caption = 'History Folder';

            trigger OnValidate()
            begin
                "History Folder" := FolderCheck("History Folder");
            end;
        }
        field(4; "Prefix FileName After Process"; Text[30])
        {
            Caption = 'Prefix FileName After Process';
        }
        field(5; "FileName Before Process"; Text[80])
        {
            Caption = 'FileName Before Process';

            trigger OnValidate()
            begin
                if "FileName Before Process" <> '' then
                    while StrPos("FileName Before Process", '\') <> 0 do
                        "FileName Before Process" :=
                          CopyStr("FileName Before Process", StrPos("FileName Before Process", '\') + 1);

                "FileName Before Process" := UpperCase("FileName Before Process");
            end;
        }
        field(7; "Excel Sheet Password"; Text[30])
        {
            Caption = 'Excel Sheet Password';
        }
        field(8; "E-mail Standard Text Code"; Code[10])
        {
            Caption = 'E-mail Standard Text Code';
            TableRelation = "Standard Text";
        }
        field(9; "Period Date Calculation"; DateFormula)
        {
            Caption = 'Period Date Calculation';
        }
        field(10; "Import Folder"; Text[250])
        {
            Caption = 'Import Folder';

            trigger OnValidate()
            begin
                "Import Folder" := FolderCheck("Import Folder");
            end;
        }
        field(11; "Default Quote Vendor"; Code[20])
        {
            Caption = 'Quote Vendor No.';
            TableRelation = Vendor;
        }
        field(12; "Additional Vendor Selection"; Option)
        {
            Caption = 'Additional Vendor Selection';
            OptionCaption = ' ,Purchase Price,Purchase Line Discount,Both';
            OptionMembers = " ","Purchase Price","Purchase Line Discount",Both;
        }
        field(13; "Outlook Send Mail FolderID"; Blob)
        {
            Caption = 'Outlook Send Mail FolderID';
        }
        field(14; "Outlook Send Mail Folder Path"; Text[250])
        {
            Caption = 'Outlook Mail Box Folder Path';
        }
        field(15; "Outlook Open Dialog"; Boolean)
        {
            Caption = 'Display e-mail';
        }
        field(16; "Outlook Mail Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8004090),
                                                                FieldID = const(16)));
            Caption = 'Outlook Mail Text';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure FolderCheck(FolderName: Text[250]): Text[250]
    begin
        if StrPos(FolderName, '\') > 0 then begin
            while (CopyStr(FolderName, StrLen(FolderName)) <> '\') and (StrLen(FolderName) > 0) do
                FolderName := CopyStr(FolderName, 1, StrLen(FolderName) - 1);
        end else
            FolderName := '';
        exit(FolderName);
    end;
}

