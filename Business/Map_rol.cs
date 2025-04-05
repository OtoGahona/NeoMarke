using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business
{
    internal class Map_rol
    {
        //Metodo para mapear de Rol a RolDTO
        private RolDTO MapToDTO(Rol rol)
        {
            return new RolDTO
            {
                Id = rol.id,
                Nombre = rol.nombre,
                Descripcion = rol.descripcion //Si existe en la entidad
            };
        }
        //Metodo para mapear de RolDTO a Rol
        private Rol MapToEntity(RolDTO rolDTO)
        {
            return new Rol
            {
                id = rolDTO.Id,
                nombre = rolDTO.Nombre,
                descripcion = rolDTO.Descripcion //Si existe en la entidad
            };
        }
        //Metodo para mapear una lista de Rol a una lista de RolDTO
        private IEnumerable<RolDTO> MapToDTOList(IEnumerable<Rol> roles)
        {
            var rolDTO = new List<RolDTO>();
            foreach (var rol in roles)
            {
                rolDTO.Add(MapToDTO(rol));
            }
            return rolesDTO;
        }
    }
}
