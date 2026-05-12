TableExtension 50063 "Source Code SetupEXT" extends "Source Code Setup"
{
    fields
    {
        modify("Post Recognition")
        {
            Caption = 'Post Recognition';
        }
        modify("Post Value")
        {
            Caption = 'Post Value';
        }
        modify("Job Journal")
        {
            Caption = 'Job Journal';
        }
        modify("Compress Job Ledger")
        {
            Caption = 'Compress Job Ledger';
        }
        modify("Job G/L Journal")
        {
            Caption = 'Job G/L Journal';
        }
        modify("Job G/L WIP")
        {
            Caption = 'Job G/L WIP';
        }
        modify("Whse. Item Journal")
        {
            Caption = 'Whse. Item Journal';
        }
        modify("Whse. Phys. Invt. Journal")
        {
            Caption = 'Whse. Phys. Invt. Journal';
        }
        modify("Whse. Reclassification Journal")
        {
            Caption = 'Whse. Reclassification Journal';
        }
        modify("Whse. Put-away")
        {
            Caption = 'Whse. Put-away';
        }
        modify("Whse. Pick")
        {
            Caption = 'Whse. Pick';
        }
        modify("Whse. Movement")
        {
            Caption = 'Whse. Movement';
        }
        modify("Compress Whse. Entries")
        {
            Caption = 'Compress Whse. Entries';
        }
        field(11307; "Financial Journal"; Code[10])
        {
            Caption = 'Financial Journal';
            TableRelation = "Source Code";
        }
        field(2000020; "Domiciliation Journal"; Code[10])
        {
            Caption = 'Domiciliation Journal';
            TableRelation = "Source Code";
        }
        field(8002000; "Note of Expenses Journal"; Code[10])
        {
            Caption = 'Note of Expenses Journal';
            TableRelation = "Source Code";
        }
        field(8003900; "Job Working Time Journal"; Code[10])
        {
            Caption = 'Job Working Time Journal';
            TableRelation = "Source Code";
        }
        field(8003901; "Post Transfer"; Code[10])
        {
            Caption = 'Post Job Transfer';
            TableRelation = "Source Code";
        }
    }
}

