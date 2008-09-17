#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <magic.h>

MODULE = File::Magic		PACKAGE = File::Magic		

long
load( magicfile = NULL, flags = 0 )
    char *magicfile;
    int  flags;

    PROTOTYPE: ;$$

    PPCODE:
    {
        magic_t m = magic_open( flags );
        if( m )
        {
            magic_load( m, magicfile );
            XSRETURN_IV((long int)m);
        }
        else
        {
            XSRETURN_IV((long int)0);
        }
    }

const char *
filetype(magic, filename)
    long magic
    char *filename;

    PROTOTYPE: $$

    PREINIT:
    const char *type;

    PPCODE:
    {
        if( 0 == magic )
        {
            Perl_croak(aTHX_ "Invalid magic instance");
        }
        type = magic_file((magic_t) magic, filename);
        if( type )
        {
            XSRETURN_PV(type);
        }
        else
        {
            XSRETURN_UNDEF;
        }
    }

void
unload(magic)
    long magic;

    PPCODE:
    {
        if( magic )
        {
            magic_close( (magic_t)magic );
        }
    }

const char *
error(magic)
    long magic;

    PPCODE:
    {
        const char *err;

        if( 0 == magic )
        {
            Perl_croak(aTHX_ "Invalid magic instance");
        }
        err = magic_error((magic_t)magic);
        if(err)
        {
            XSRETURN_PV(err);
        }
        else
        {
            XSRETURN_UNDEF;
        }
    }

