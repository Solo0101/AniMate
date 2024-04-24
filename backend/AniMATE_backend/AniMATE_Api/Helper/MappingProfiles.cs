using AutoMapper;

namespace AniMATE_Api.Helper;

public class MappingProfiles : Profile
{
    public MappingProfiles()
    {
        CreateMap<Models.User, DTOs.RegisterDto>();
        CreateMap<Models.User, DTOs.LoginDto>();
        CreateMap<Models.User, DTOs.ManageUserDto>();
        CreateMap<Models.User, Views.LoginResponseView>();
        
        CreateMap<DTOs.RegisterDto, Models.User>();
        CreateMap<DTOs.LoginDto, Models.User>();
        CreateMap<DTOs.ManageUserDto, Models.User>();
        
        CreateMap<Views.LoginResponseView, Models.User>();
        
    }
}