#pragma once

#define OIIO_IMPORT
#define OIIO_EXPORT
#define OIIO_LOCAL

#if defined(OpenImageIO_EXPORTS) || defined(OpenImageIO_Util_EXPORTS)
#    define OIIO_API OIIO_EXPORT
#else
#    define OIIO_API OIIO_IMPORT
#endif
