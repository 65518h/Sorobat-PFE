Table 8003911 "Document Progress Degree"
{
    // //PROJET GESWAY 26/09/02 Nouvelle table de l'avancement du chantier

    Caption = 'Document Progress Degree';
    // LookupPageID = 8003921;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";

            trigger OnValidate()
            begin
                if "Document Type" <> 0 then begin
                    JobProgress.SetFilter(Code, '<%1', Code);
                    if JobProgress.Find('+') and (JobProgress."Document Type" > "Document Type") then
                        Error(Text8003900, JobProgress."Document Type");
                end;
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Code", "Document Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        JobProgress: Record "Document Progress Degree";
        Text8003900: label 'Job status cannot be under %1.';
}

