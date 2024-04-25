using AutoMapper;

namespace AniMATE_Api.Helper;

public class MappingProfiles : Profile
{
    public MappingProfiles()
    {
        CreateMap<DTOs.RegisterDto, Models.User>();
        CreateMap<DTOs.LoginDto, Models.User>();
        CreateMap<DTOs.ManageUserDto, Models.User>();
        CreateMap<DTOs.PetDto, Models.Pet>();
        
        CreateMap<Models.User, DTOs.RegisterDto>();
        CreateMap<Models.User, DTOs.LoginDto>();
        CreateMap<Models.User, DTOs.ManageUserDto>();
        CreateMap<Models.Pet, DTOs.PetDto > ();
        
        CreateMap<Models.User, Views.LoginResponseView>();
        CreateMap<Models.Pet, Views.PetView>();
        CreateMap<ICollection<Models.Pet>, ICollection<Views.PetView>>();
    }
}