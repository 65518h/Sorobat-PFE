TableExtension 50136 "Sales Comment Line ArchiveEXT" extends "Sales Comment Line Archive"
{
    fields
    {
        modify(Comment)
        {
            Description = '+REF+ 80 > 160';
        }

        field(8001400; Separator; Integer)
        {
        }
    }
}

