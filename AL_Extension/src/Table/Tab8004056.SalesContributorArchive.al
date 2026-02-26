Table 8004056 "Sales Contributor Archive"
{
    // //DEVIS GESWAY 07/11/02 Nouvelle table des intervenants d'un document vente

    Caption = 'Sales Contributor Archive';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header Archive"."No." where("Document Type" = field("Document Type"),
                                                                "Version No." = field("Version No."),
                                                                "Doc. No. Occurrence" = field("Doc. No. Occurrence"));
        }
        field(5; Contributor; Code[20])
        {
            Caption = 'Contributor';
            NotBlank = true;
            TableRelation = Code.Code where("Table No" = const(8004050),
                                             "Field No" = const(5));
        }
        field(6; Responsibility; Text[30])
        {
            CalcFormula = lookup(Code.Description where("Table No" = const(8004050),
                                                         "Field No" = const(5),
                                                         Code = field(Contributor)));
            Caption = 'Job Responsibility';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Contact Type"; Option)
        {
            Caption = 'Contact Type';
            FieldClass = Normal;
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;
        }
        field(11; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = if ("Contact Type" = const(Company)) Contact."No." where(Type = const(Company))
            else
            if ("Contact Type" = const(Person)) Contact."No." where(Type = const(Person));

            trigger OnValidate()
            begin
                Contact.Get("Contact No.");
                case Contact.Type of
                    Contact.Type::Company:
                        "Contact Company Name" := Contact.Name;
                    Contact.Type::Person:
                        begin
                            "Contact Type" := Contact.Type;
                            "Contact Company Name" := Contact."Company Name";
                            "Contact Name" := Contact.Name;
                        end;
                end;
                "Contact City" := Contact.City;
                "Contact Phone No." := Contact."Phone No.";
            end;
        }
        field(12; "Contact Company Name"; Text[30])
        {
            Caption = 'Company Name';
            Editable = false;
        }
        field(13; "Contact Name"; Text[30])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(14; "Contact City"; Text[30])
        {
            Caption = 'City';
            Editable = false;
        }
        field(15; "Contact Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(17; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", Contributor)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Contact: Record Contact;
}

