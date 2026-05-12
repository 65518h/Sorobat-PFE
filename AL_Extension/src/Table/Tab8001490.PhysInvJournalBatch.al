Table 8001490 "Phys. Inv. Journal Batch"
{
    // //+REF+PHYS_INV CW 27/11/09

    Caption = 'Phys. Inv. Journal Batch';
    DataCaptionFields = Name, Description;
    // LookupPageID = 8001490;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;
            TableRelation = Location;
        }
        field(2; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(100; "No. of Lines"; Integer)
        {
            //blankzero = true;
            CalcFormula = count("Phys. Inv. Journal Line" where("Location Code" = field("Location Code"),
                                                                 "Journal Batch Name" = field(Name)));
            Caption = 'No. of Lines';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Location Code", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PhysInvJnlLine.SetRange("Location Code", "Location Code");
        PhysInvJnlLine.SetRange("Journal Batch Name", Name);
        PhysInvJnlLine.DeleteAll(true);
    end;

    trigger OnRename()
    begin
        PhysInvJnlLine.SetRange("Location Code", "Location Code");
        PhysInvJnlLine.SetRange("Journal Batch Name", xRec.Name);
        while PhysInvJnlLine.Find('-') do
            PhysInvJnlLine.Rename("Location Code", Name, PhysInvJnlLine."Line No.");
    end;

    var
        PhysInvJnlLine: Record "Item Journal Line";
}

