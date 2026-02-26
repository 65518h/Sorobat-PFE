Table 8003907 "Company Setup"
{
    // //PERSONNALISATION CLA 10/06/03 Table de paramétrage pour personnalisations
    //                                 SITREEN : "ID Generate purch. difference" = 50000


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "ID Generate purch. difference"; Integer)
        {
            Caption = 'Generate purch. difference';
            //GL2024 License TableRelation = Object.ID where(Type = filter(Codeunit));

            //GL2024 License
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = filter(Codeunit));
            //GL2024 License
            //GL2024 License


            trigger OnValidate()
            begin
                CalcFields("Object Name Field 2");
            end;
        }
        field(3; "Object Name Field 2"; Text[30])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Codeunit),
                                                                           "Object ID" = field("ID Generate purch. difference")));
            Caption = 'Object Name Field 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Keep Invoiced Order"; Boolean)
        {
            Caption = 'Keep Invoiced Order';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
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
}

