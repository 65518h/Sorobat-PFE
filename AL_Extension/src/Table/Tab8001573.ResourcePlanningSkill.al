Table 8001573 "Resource / Planning Skill"
{
    //GL2024  ID dans Nav 2009 : "8035002"
    // //AFF PLAN PLANNINGFORCE OFE 12/06/09
    // //PLAN : + Field 50000

    Caption = 'Resource Skill';
    LookupPageID = "Resource Skills";

    fields
    {
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = Resource."No.";
        }
        field(3; "Skill Code"; Code[10])
        {
            Caption = 'Skill Code';
            NotBlank = true;
            TableRelation = "Planning Skill";

            trigger OnValidate()
            var
                ResSkillMgt: Codeunit "Resource Skill Mgt.";
                ResSkill: Record "Resource Skill";
            begin
            end;
        }
        field(4; "Assigned Quantity"; Decimal)
        {
            Caption = 'Assigned Quantity';
        }
        field(5; "Skill Description"; Text[50])
        {
            CalcFormula = lookup("Planning Skill".Description where(Code = field("Skill Code")));
            Caption = 'Skill Description';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "No.", "Skill Code")
        {
        }
        key(STG_Key2; "Skill Code", "No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = "Assigned Quantity";
        }
    }

    fieldgroups
    {
    }
}

