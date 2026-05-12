TableExtension 50876 "Job Journal BatchEXT" extends "Job Journal Batch"
{
    fields
    {
        field(8003900; "Transfer Journal Name"; Code[10])
        {
            Caption = 'Transfer Journal Name';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(8003901; "Default Location Code"; Code[20])
        {
            Caption = 'Default Location Code';
            TableRelation = Location;
        }
    }










}

